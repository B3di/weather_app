import SwiftUI

struct WeatherView: View {
    @State var navigated = false
    
    @State var weather: ResponseBody
    
    @State private var otherLocation: String = ""
    var weatherManager = WeatherManager()
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .center, spacing: 10) {
                    Text("Today, \(Date().formatted(.dateTime.month().day()))")
                        .fontWeight(.light)
                    
                    TextField(weather.name,
                              text: $otherLocation)
                    .onSubmit {
                        Task {
                            do {
                                weather = try await weatherManager.getCurrentWeatherForCity(city: otherLocation, countryCode: "pl")
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                    }
                    .bold().font(.title).multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(10)
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 16) {
                            Image(systemName: "cloud.fill")
                                .font(.system(size:55))
                            
                            Text(weather.weather[0].main).font(.system(size: 18))
                        }
                        .frame(width: 100, alignment: .center)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size:85))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 0)
                    AsyncImage(url: URL(string: "https://www.transparentpng.com/thumb/travel-insurance/travel-insurance-simple-11.png")) { image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Button ("Click for elderly mode", action: {
                        self.navigated.toggle()
                    }).sheet(isPresented: $navigated) {
                        ElderlyView(weather: weather)
                    }
                                       
             
                    .bold().font(.title3)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        
            VStack {
                Spacer()
                VStack (alignment: .center, spacing: 20){
                   Text("Weather now")
                        .bold().padding(.leading)
                    HStack {
                        WeatherRow(logo: "thermometer.snowflake", name: "Min temp", value: (weather.main.tempMin.roundDouble() + "°"))
                        Spacer()
                        WeatherRow(logo: "thermometer.sun", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°" + "      "))
                    }
                    HStack {
                        WeatherRow(logo: "aqi.medium", name: "Pressure", value: (weather.main.pressure.roundDouble() + "hPa"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%" + "   "))
                    }
                    HStack {
                        WeatherRow(logo: "sunrise", name: "Sunrise", value: timeConverter(weather.sys.sunrise, format: "HH:mm"))
                        Spacer()
                        WeatherRow(logo: "sunset", name: "Sunrise", value: timeConverter(weather.sys.sunset, format: "HH:mm"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.364, saturation: 0.448, brightness: 0.256))
                .background(.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.8, saturation: 0.448, brightness: 0.256))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
