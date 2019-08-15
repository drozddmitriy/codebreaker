module GameHelper
  def check_code(input_code, code)
    result = ''
    code_clone = code.clone
    input_code_clone = input_code.clone

    input_code.chars.each_with_index do |char, index|
      if char == code[index]
        result << '+'
        code_clone[index] = input_code_clone[index] = '*'
      end
    end

    chek_code_helper(result, input_code_clone, code_clone)
  end

  def check_hint(code, hint_index)
    hints = ''

    code.chars.each_with_index do |char, index|
      hints << if index == hint_index.last
                 char
               else
                 '*'
               end
    end
    hints
  end

  def select_unique_hint_index(index)
    return index << rand(0..3) if index.empty?

    loop do
      rand_code = rand(0..3)
      next if index.include?(rand_code)

      return index << rand_code
    end
  end

  def chek_code_helper(result, input_code, code_clone)
    input_code.chars.each_with_index do |char, index|
      next unless char != '*'

      index_of_char = code_clone.index(char)

      if index_of_char
        result << '-'
        code_clone[index_of_char] = input_code[index] = '*'
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
end
