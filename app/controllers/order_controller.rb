class OrderController < ApplicationController
  # skip_before_action :verify_authenticity_token
  def index
    @typeList = Type.all
    @statusList = Status.all

  end

  def addOrder
    @selectedType = params[:type]
    @selectedItem = params[:item]
    @selectedSize = params[:size]
    @selectedQuantity = params[:qty]
    @selectedStatus = params[:status]

    @query = Menu.where(:type_id=>@selectedType ,:drink_id=> @selectedItem,:size_id=>@selectedSize).first
    @getStatus = Status.where(:id => @selectedStatus).first
    @totalPrice = @selectedQuantity.to_f * @query.price
    @result = {'id'=>@query.id,'drink'=>@query.drink,'type'=>@query.type,'size' => @query.size, 'status' => @getStatus, 'quantity' => @selectedQuantity, 'priceEach' => @query.price, 'totalPrice' => @totalPrice.round(2)}
    if request.xhr?
      render :json => {
          :file_content => @result
      }
    end
  end

  def create
    params[:data] = JSON.parse params[:data] if params[:data].is_a? String
    @data = params[:data]
    @rawData = @data.first
    @menuId = Menu.where(:drink_id=>@rawData[1]['drink']['id'],:type_id=>@rawData[1]['type']['id'],:size_id=>@rawData[1]['size']['id']).select("id").first

    # Order.create(menu_id:@menuId,status_id:@rawData[1]['status']['id'],quantity: @rawData[1]['quantity'],price: @rawData[1]['totalPrice'])
    @newOrder = Order.new
    @newOrder.menu_id = @menuId.id
    @newOrder.status_id = @rawData[1]['status']['id']
    @newOrder.quantity = @rawData[1]['quantity']
    @newOrder.price = @rawData[1]['totalPrice']
    @newOrder.save
    puts @newOrder.errors.inspect
    if request.xhr?
      render :json => {
          :file_content => @rawData[1]['totalPrice']
      }
    end
  end

  def orderData
    # @arrData = []
    # dat = 'id'
    # @list = Order.order(dat+' desc').includes(:menu)
    # @list.each do |i|
    #   @arrData.push({'id' => i.id,
    #                  'drink_name' => i.menu.drink.name,
    #                  'size_name' => i.menu.size.name,
    #                  'type_name' => i.menu.type.name,
    #                  'status' => i.status.name,
    #                  'quantity' => i.quantity,
    #                  'price' => i.price})
    # end
    colname = 'type.id'

    sql = 'SELECT `orders`.id,`orders`.quantity,`orders`.price,`type`.name,`type`.sizename,`type`.typename,`statuses`.name as `statusname`
FROM `orders`
JOIN `statuses` ON `orders`.status_id = `statuses`.id
JOIN (
SELECT `menus`.id,`drinks`.name,`sizes`.name as `sizename`,`types`.name as `typename` FROM `menus`
	JOIN `drinks` ON `menus`.drink_id=`drinks`.id
	JOIN `sizes` ON `menus`.size_id=`sizes`.id
	JOIN `types` ON `menus`.type_id = `types`.id
	) as `type` ON `orders`.`menu_id` = `type`.id'

if params[:data1]!=nil && params[:data2]!=nil
  sql += ' WHERE '+params[:data1]+' = "'+params[:data2]+'"'
end
    sql += ' ORDER BY '+colname+' DESC'
    record_array = ActiveRecord::Base.connection.execute(sql)
    # puts @arrData
    if request.xhr?
      render :json => {
          :file_content => record_array
      }
    end
  end

  def groupData
    if params[:data]=='type'
      sql = Type.all
    else if params[:data]=='size'
           sql = Size.all
         end
    end

    if request.xhr?
      render :json => {
          :file_content => sql
      }
    end

  end

  def addChange
    inputId = params[:inputId]

    # sql = Menu.joins(:param).where(param.id: id)
    sql = Menu.select('drinks.id, drinks.name').distinct.joins(:type,:drink).where(:types => {:id => inputId}) if params[:type]
    sql = Menu.select('sizes.id, sizes.name').distinct.joins(:drink,:size).where(:drinks => {:id => inputId}) if params[:item]
    sql = Menu.joins(:status).where(:statuses => {:id => inputId}) if params[:status]
    if request.xhr?
      render :json => {
          :file_content => sql
      }
    end
  end
end
