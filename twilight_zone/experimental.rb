# binary search
class Array
  def bsearch(target)
    pivot_i = length / 2

    case target <=> self[pivot_i]
    when -1
      self.take(pivot_i).bsearch(target)
    when 0
      pivot_i
    when 1
        shift_i = pivot_i + 1
        sub_a = self.drop(shift_i).bsearch(target)
        sub_a.nil? ? nil : sub_a + shift_i
    end
  end

end




class Array

  def qsort
    return self if length < 2
    piv = sample
    sml, lrg, eql = [], [], []

    self.each do |el|
      if el < piv
        sml << el
      elsif el > piv
        lrg << el
      else
        eql << el
      end
    end

    sml.qsort + eql + lrg.qsort
  end


  def msort(&prc)
    prc = Proc.new { |x, y| x <=> y } unless block_given?
    return self if length <= 1
    left, right = self.take(length / 2) , self.drop(length / 2)

    Array.merge(left.msort(&prc), right.msort(&prc), &prc)
  end

  private
    def self.merge(left, right, &prc)
      merged = []
      until left.empty? || right.empty?
        case prc.call(left.first, right.first)
        when -1
          merged << left.shift
        when 0
          merged << left.shift
        when 1
          merged << right.shift
        end
      end
        merged.concat(left)
        merged.concat(right)
        merged
    end
end
# p array.shuffle.qsort

p (1..10).to_a.shuffle.msort
