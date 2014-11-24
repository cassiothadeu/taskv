module SwitchLocale
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  private

  def default_url_options
    if I18n.locale == I18n.default_locale
      {}
    else
      {locale: I18n.locale}
    end
  end

  def set_locale
    I18n.locale = params.fetch(:locale, I18n.default_locale)
  end
end
