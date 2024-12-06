class Html_tree
  include Enumerable
  attr_reader :root
  def initialize(html_input)
      if html_input.is_a?(String)
        @root = parse_main(html_input)
      elsif html_input.is_a?(Tag)
        @root = html_input
      else
        raise ArgumentError, 'Ошибка!'
      end
    end
  
  def dfs_root(&block)
      dfs_tag(@root, &block)
  end  
  
  def dfs_tag(tag, &block)
    yield tag
    tag.children.each do |child|
      dfs_tag(child, &block)
    end
  end 

  def bfs_root
    queue = [@root]
    until queue.empty?
      tag = queue.shift
      yield tag
      queue.concat(tag.children)
    end
  end

  def each(type: :dfs_root, &block)
    self.send(type, &block)
  end

  def parse_main(html_string)
      elements = parse_html(html_string.strip)
      if elements.size == 1
          return elements[0]
      else
          root = Tag.new(name:'root')
          elements.each { |element| root.add_child(element) }
          return root
      end
  end
  
  def parse_html(html_string)
      tags = []
      while !html_string.empty?
          if html_string =~ /\A<(\w+)(.*?)>(.*?)<\/\1>/m
              full_tag_text = $&
              tag_name = $1
              attributes = $2
              tag_content = $3.strip
              attributes_parsed = parse_attributes(attributes)
              tag = Tag.new(name:tag_name, attributes:attributes_parsed)
              if tag_content =~ /\A<(\w+)(.*?)>(.*?)<\/\1>/m    
                  tag.add_child(parse_html(tag_content))
              else          
                  tag = Tag.new(name:tag_name, attributes:attributes_parsed, content:tag_content)
              end
              tags << tag
              html_string.sub!(full_tag_text, '').strip
          else
              break
          end
      end
      return tags
  end

  def parse_attributes(attributes_string)
      attributes = {}
      attributes_string.scan(/(\w+)=["'](.*?)["']/).each do |key, value|
          attributes[key] = value
      end
      return attributes
  end

  def to_html
      @root.to_html
  end
end


class Tag
  attr_reader :name,:children, :attributes, :content
  def initialize(name:"", attributes:{}, content:"")
      @name = name
      @children = []              
      @attributes = attributes  
      @content = content        
  end
  
  def add_child(tag)
      if tag.is_a?(Tag)
      @children << tag
      elsif tag.is_a?(Array)
          tag.each {|child| @children << child}
      end
  end

  def content_length
      @content.length
    end
  
  def has_children?
      !@children.empty?
  end

  def children_count
      @children.size
  end

  def to_html(indent_level = 0)
      indent = "  " * indent_level 
      attributes = @attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(" ")
      opening_tag = "#{indent}<#{@name}#{' ' unless attributes.empty?}#{attributes}>"
      if @children.any?
        inner_html = @children.map { |child| child.to_html(indent_level + 1) }.join("\n")
        closing_tag = "#{indent}</#{@name}>"
        "#{opening_tag}\n#{inner_html}\n#{closing_tag}"
      elsif @content
        closing_tag = "</#{@name}>"
        "#{opening_tag}#{@content}#{closing_tag}"
      else
        "#{opening_tag}</#{@name}>"
      end
    end 
end


html = Tag.new(name:'html')
body = Tag.new(name:'body')
div = Tag.new(name:'div',attributes:{class: 'test1'}, content:'test22')
div2 = Tag.new(name:'div',attributes:{class: 'test1'}, content:'test33')
span = Tag.new(name:'span', content: 'test3')


html.add_child(body)
body.add_child([div,span])
div.add_child(div2)

mytree = Html_tree.new(html)

puts mytree.root.name
puts mytree.to_html
