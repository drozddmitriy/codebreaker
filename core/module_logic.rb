module Logic
  def check_code(try, attempts, input_code, code)
    return false if try > attempts
    return true if input_code == code

    result = ''
    code_clone = code.clone
    input_code_clone = input_code.clone

    input_code.chars.each_with_index do |char, index|
      if char == code[index]
        result << '+'
        code_clone[index] = input_code_clone[index] = '*'
      end
    end

    input_code_clone.chars.each_with_index do |char, index|
      next unless char != '*'

      index_of_char = code_clone.index(char)

      if index_of_char
        result << '-'
        code_clone[index_of_char] = input_code_clone[index] = '*'
      end
    end
    result
  end

  def rand_code
    code = ''
    4.times do
      code << rand(1...6).to_s
    end
    code
  end

  def hint(code)
    hint_index = rand(0...3)
    hints = ''

    code.chars.each_with_index do |char, index|
      hints << if index == hint_index
                 char
               else
                 ' '
               end
    end
    hints
  end

  def to_hash(array)
    keys = %w[name attempts hints_total hints_used difficulty try]
    hash = {}
    keys.zip(array) { |key, val| hash[key.to_sym] = val }
    hash
  end
end
