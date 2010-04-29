require 'date'

module ToOutput
  def to_output
    to_s
  end
  def self.config(*args)
    @__to_output_config ||= DEFAULTS.dup
    if args.length == 1
      return @__to_output_config[args.first.to_sym]
    elsif args.length == 2
      return @__to_output_config[args.first.to_sym] = args[1]
    end
  end
  DEFAULTS = {}
  def self.default(*args)
    if args.length == 1
      return DEFAULTS[args.first.to_sym]
    elsif args.length == 2
      return DEFAULTS[args.first.to_sym] = args[1]
    end
  end
  def self.reset_config
    @__to_output_config = DEFAULTS.dup
  end
end

class Object
  include ToOutput
end

class NilClass
  def to_output
    ToOutput.config(:nil)
  end
  ToOutput.default(:nil, 'None')
end

class TrueClass
  def to_output
    ToOutput.config(:true)
  end
  ToOutput.default(:true, 'Yes')
end

class FalseClass
  def to_output
    ToOutput.config(:false)
  end
  ToOutput.default(:false, 'No')
end

class Date
  def to_output
    strftime(ToOutput.config(:date))
  end
  ToOutput.default(:date, '%d/%m/%Y')
end

class DateTime
  def to_output
    strftime(ToOutput.config(:datetime))
  end
  ToOutput.default(:datetime, '%d/%m/%Y %H:%M')
end

class Time
  def to_output
    time = ToOutput.config(:localtime) ? self.localtime : self
    time.strftime(ToOutput.config(:datetime))
  end
  ToOutput.default(:localtime, true)
end


class Array
  def to_output
    self.map(&:to_output).join ToOutput.config(:array_glue)
  end
  ToOutput.default(:array_glue, ', ')
end
