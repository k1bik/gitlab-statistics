# typed: strict

module Common
  module Utils
    extend T::Sig

    sig { params(date: T.any(Time, String)).returns(String) }
    def self.format_date(date)
      case date
      when Time
        date.strftime("%d.%m.%Y")
      when String
        Time.parse(date).strftime("%d.%m.%Y")
      end
    end
  end
end
