class MenuController < ApplicationController
  def index
    @type = Type.all
    @size = Size.all
  end

  def retrieveMenu
    sql = 'SELECT `menus`.id, `menus`.price, `drinks`.name,`types`.name, `sizes`.name FROM `menus`
JOIN `drinks` ON `menus`.drink_id = `drinks`.id
JOIN `types` ON `menus`.type_id = `types`.id
JOIN `sizes` ON `menus`.size_id = `sizes`.id
ORDER BY `menus`.id DESC'
    results = ActiveRecord::Base.connection.execute(sql)
    if request.xhr?
      render :json => {
          :file_content => results
      }
    end
  end

  def create
    type = params[:type]
    drink = params[:drink]
    size = params[:size]
    price = params[:price].to_f

    drinkName = Drink.where(name: drink).first_or_create
    drink_id = drinkName.id

    check = Menu.where(drink_id:drink_id, type_id: type, size_id:size).first
    if check==nil
      menu = Menu.new
      menu.drink_id = drink_id
      menu.type_id = type
      menu.size_id = size
      menu.price = price
      menu.save
      flag = menu.id
    else
      flag = 0
    end

    if request.xhr?
      render :json => {
          :file_content => flag
      }
    end
  end
end
