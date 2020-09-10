# AirQuality

A utility package for working with air quality measurements.

Currently, supports computing Air Quality Index (AQI) scores given PM2.5 concentrations and US categories.

## Usage

```swift

let someVal = AirQualityIndex.compute(forPollutant: .PM_25, atConcentration: 37.0)

switch someVal {
case .success(let (aqi, category)):
    print("Your AQI is: \(aqi), which is: \(category.label())")
case .failure(let err):
    switch err {
    case .ConcentrationOutOfRange:
        print("Your AQI is literally off the charts.")
    }
}
```

## TODO

 - More pollutants
 - Probably all kinds of other stuff
 
 ## Installation
 
 Any way you like, but SPM does work just fine. Note that the branch you want to be following is `main`.

## Relevant references:

- [EPA Technical Assistance Document for the Reporting of Daily Air Quality –the Air Quality Index (AQI)](https://www.airnow.gov/sites/default/files/2018-05/aqi-technical-assistance-document-may2016.pdf)
- ["AQI Basics"](https://www.airnow.gov/aqi/aqi-basics/)
- [Revised air Quality Standards for Particle Pollution and Updates to the air Quality Index (AQI)](https://www.epa.gov/sites/production/files/2016-04/documents/2012_aqi_factsheet.pdf)

