class TsortableHash < Hash

  include TSort

  alias tsort_each_node each_key

  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end

class TsortableArray < Array

  include TSort

  alias tsort_each_node each

  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end
