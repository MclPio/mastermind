module GenerateCode
  def generate_code(length, range)
    code = ''
    length.times do
      code += rand(1..range).to_s
    end
    puts code
    code
  end
end
