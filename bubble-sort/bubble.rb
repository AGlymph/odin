def bubble_sort(array)  
  array[...-1].each_index do |i|
    array[...-i].each_index do |index| 
      if array[index] > array[index + 1]
        temp = array[index]
        array[index] = array[index + 1]
        array[index + 1] = temp
      end
    end
  end
  array
end

p bubble_sort([4,3,78,2,0,2])