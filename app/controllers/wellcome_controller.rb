class WellcomeController < ApplicationController
  def index

      @cities = City.limit(3).pluck(:ciudad)
        # elimina los espacios de los nombres de las ciudades con dos palabras, y los reemplaza con una barra baja (_)
        #if params[:city] != nil
         # params[:city].gsub!(" ", "_")
        #end
     
        #comprueba que los parámetros de estado y ciudad no estén vacíos antes de llamar a la API
        #if params[:city] != "" && params[:city] != nil
     
        if params[:city].present?
          # elimina los espacios de los nombres de las ciudades con dos palabras, y los reemplaza con una barra baja (_). Los guarda en la misma variable por la exclamacion.
          params[:city].gsub!(" ", "_")
      
          results = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/Spain/#{params[:city]}.json")
        
          # si no se devuelve un error de la llamada, rellana tus variables de instancia con el resultado de la llamada
          if results['response']['error'] == nil || results['error'] ==""      
            @location = results['location']['city']
            @temp_f = results['current_observation']['temp_f']
            @temp_c = results['current_observation']['temp_c']
            @weather_icon = results['current_observation']['icon_url']
            @weather_words = results['current_observation']['weather']
            @forecast_link = results['current_observation']['forecast_url']
            @real_feel_f = results['current_observation']['feelslike_f']
            @real_feel_c = results['current_observation']['feelslike_c']

            @ciudad = City.find_or_create_by(ciudad: params[:city])
  
          elsif results['response']['error'] != nil
            # si sí hay un error, informa de ello mediante @error variable     
            @error = results['response']['error']['description']
          end
          
        end
  end
  
  def test
    response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/Spain/Malaga.json")
    
    @location = response['location']['city']
    @temp_f = response['current_observation']['temp_f']
    @temp_c = response['current_observation']['temp_c']
    @weather_icon = response['current_observation']['icon_url']
    @weather_words = response['current_observation']['weather'] 
    @forecast_link = response['current_observation']['forecast_url']
    @real_feel = response['current_observation']['feelslike_c']
  end


end
