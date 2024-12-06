require 'date'

class Binary_Search_Tree

  include Enumerable

  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(student)
    @root = insert_node(@root, student)
  end

  def each(&block)
    DFS(@root, &block)
  end

  private

  def insert_node(node, student)

    return Node.new(student) if node.nil?

    if student.birth_date < node.student.birth_date
      node.left = insert_node(node.left, student)
    else
      node.right = insert_node(node.right, student)
    end

    node

  end

  def DFS(node, &block)

    return if node.nil?

    DFS(node.left, &block)
    yield node.student
    DFS(node.right, &block)

  end

  class Node

    attr_accessor :student, :left, :right

    def initialize(student)

      @student = student
      @left = nil
      @right = nil

    end

  end

end
