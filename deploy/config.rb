require 'yaml'

class Config < HashWithIndifferentAccess
  def self.instance
    @instance ||= Config.new("#{__dir__}/config.yml")
  end

  protected

  def initialize(file)
    super({})
    merge!(YAML.load_file(file).with_indifferent_access)

    raise "'config.yml' must specify a value for `prose_site_name`" if self[:prose_site_name].blank?
    raise "'config.yml' must specify a value for `path_to_404_html`" if self[:path_to_404_html].blank?
    raise "'config.yml' must specify a value for `hosted_zone_name`" if self[:hosted_zone_name].blank?
    raise "'config.yml' must specify a value for `domain_name`" if self[:domain_name].blank?

    self[:hyphen_site_name] = self[:hyphen_site_name] || self[:prose_site_name].gsub(/['"]/,"").gsub(" ", "-").downcase
    self[:camel_site_name] = self[:camel_site_name] || self[:prose_site_name].gsub(/['"]/,"").gsub(" ", "_").camelcase
    self[:primary_bucket_name] = self[:primary_bucket_name] || "#{self[:hyphen_site_name]}-primary"
    self[:replica_bucket_name] = self[:replica_bucket_name] || "#{self[:hyphen_site_name]}-replica"
    self[:path_to_404_html] = "/#{self[:path_to_404_html]}" if self[:path_to_404_html][0] != '/'
  end
end
