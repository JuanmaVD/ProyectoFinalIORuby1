class Array
    def standard_deviation
      mean = sum.to_f / size
      variance = inject(0) { |variance, x| variance += (x - mean) ** 2 }
      Math.sqrt(variance / (size - 1))
    end
  end