module Codebreaker
  module GameHelper
    PLUS = '+'.freeze
    MINUS = '-'.freeze

    def check_code(input_code, code)
      code_clone = code.split('')
      input_code_clone = input_code.split('')
      matched_position_digits(code_clone, input_code_clone).join + matched_digits(code_clone, input_code_clone).join
    end

    def matched_position_digits(code_clone, input_code_clone)
      code_clone.map.with_index do |_, index|
        next unless code_clone[index] == input_code_clone[index]

        input_code_clone[index], code_clone[index] = nil
        PLUS
      end
    end

    def matched_digits(code_clone, input_code_clone)
      input_code_clone.compact.map do |number|
        next unless code_clone.include?(number)

        code_clone.delete_at(code_clone.index(number))
        MINUS
      end
    end

    def check_hint(code, hint_index)
      code.chars.each_with_index.map { |char, index| index == hint_index.last ? char : '*' }.join
    end

    def select_unique_hint_index(index)
      return index << rand(0..3) if index.empty?

      loop do
        rand_code = rand(0..3)
        next if index.include?(rand_code)

        return index << rand_code
      end
    end

    def rand_code
      (1..4).map { rand(1...6) }.join
    end
  end
end
