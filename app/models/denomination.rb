class Denomination < ApplicationRecord
  require 'csv'

  def self.process_data data, stage
    data.shift
    result = array_permutations 0, data.transpose
    zipper result, stage.to_i
  end

  def self.process_csv csv
    rowarray = Array.new
    rowarray_disp = []
    CSV.foreach(csv.path) do |row|
      rowarray << row
      rowarray_disp = rowarray
    end
    rowarray_disp
  end

private
  def self.array_permutations index, array
    result = []
    array = array.map &:compact
    if index == array.size
      result << ""
      return result
    end
    array[index].each do |element|
      array_permutations(index + 1, array).each do |x|
        result << "#{element}, #{x}"
      end
    end
    return result
  end

  def self.zipper combinations, start_value
    denominations = start_value...(combinations.size + start_value)
    denominations.zip combinations
  end

end
