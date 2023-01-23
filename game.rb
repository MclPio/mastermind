require_relative 'generate_code'

class Test
  include GenerateCode
end

x = Test.new
p x.generate_code(4,9)