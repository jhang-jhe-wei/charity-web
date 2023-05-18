# frozen_string_literal: true

module ApplicationHelper
  def pagenator(resource_name, resources, query: '', backgroundColor: '#00CE39')
    bubble do
      header(margin: 'none', backgroundColor:) do
        vertical_box do
          text '功能頁', gravity: 'center', size: 'xl', align: 'center', color: '#FFFFFF'
        end
      end
      body margin: 'none' do
        unless resources.first_page?
          message_button '第一頁', "#{resource_name}/1?#{query}", style: 'secondary', margin: 'md'
          message_button '上一頁', "#{resource_name}/#{resources.prev_page}?#{query}", style: 'secondary', margin: 'md'
        end
        unless resources.blank? || resources.last_page?
          message_button '下一頁', "#{resource_name}/#{resources.next_page}?#{query}", style: 'secondary', margin: 'md'
            message_button '最後一頁', "#{resource_name}/#{resources.total_pages}?#{query}", style: 'secondary', margin: 'md'
        end

        yield if block_given?
      end
      footer do
        text "目前在 #{resources.current_page}/#{[resources.total_pages, 1].max} 頁", align: 'center'
      end
    end
  end
end
