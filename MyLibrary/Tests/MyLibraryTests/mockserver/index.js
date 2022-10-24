const express = require('express')
const app = express()
const port = 3000

app.get('/data/2.5/weather', getWeather)

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

function getWeather(req, res) 
{
    res.send('{"coord":{"lon":-123.262,"lat":44.5646},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":77.07,"feels_like":77.34,"temp_min":70.27,"temp_max":78.6,"pressure":1018,"humidity":61,"sea_level":1018,"grnd_level":1010},"visibility":10000,"wind":{"speed":5.99,"deg":16,"gust":7.65},"clouds":{"all":0},"dt":1665261560,"sys":{"type":2,"id":2006038,"country":"US","sunrise":1665238765,"sunset":1665279683},"timezone":-25200,"id":5720727,"name":"Corvallis","cod":200}')
}