yaml_erb = IO.read("#{Rails.root}/config/fluentd.yml")
yaml = ERB.new(yaml_erb).result
FLUENTD_CONFIG = HashWithIndifferentAccess.new(YAML.load(yaml))[Rails.env] unless Object.const_defined? :FLUENTD_CONFIG

# First argument is tag prefix.
Fluent::Logger::FluentLogger.open(FLUENTD_CONFIG[:prefix], host: FLUENTD_CONFIG[:host], port: FLUENTD_CONFIG[:port])
