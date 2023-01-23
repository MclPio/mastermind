module GenerateCode
  def generate_code(length, range)
    code = ''
    length.times do
      code += rand(1..range).to_s
    end
    code
  end
end


class Test
  include GenerateCode
end

x = Test.new
p x.generate_code(4,9)