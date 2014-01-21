require "heroku/command/config"

class Heroku::Command::Config
  # config:rollback VERSION
  #
  # roll back the config variables to an older version
  #
  #Example:
  #
  # $ heroku config:rollback v42
  # Rolling back example config vars to version v42... done
  #
  def rollback
    unless release = shift_argument
      error("Usage: heroku config:rollback RELEASE")
    end
    validate_arguments!

    release_data = api.get_release(app, release).body
    vars = api.get_config_vars(app).body
    vars.reject! {|k,v| k =~ /HEROKU_POSTGRES/}

    unless release_data['env'].empty?
      env = release_data['env'].reject! {|k,v| k =~ /HEROKU_POSTGRES/}
      action("Rolling back #{app} config vars to #{release}") do
        api.put_config_vars(app, env)

        unless vars.empty?
          keys_to_unset = vars.keys - env.keys
          keys_to_unset.each do |key|
            api.delete_config_var(app, key)
          end
        end
      end
    else
      display("#{release} has no config vars.")
    end
  end
end
