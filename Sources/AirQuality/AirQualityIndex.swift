public enum Pollutant {
    case PM_25
    
    public func aqiBreakpoints() -> [(category: AqiCategory, min: Double, max: Double)] {
        // the threshold values for this pollutant for each AQI category
        switch self {
        case .PM_25:
            return [
                (.Good, 0.0, 12.0),
                (.Moderate, 12.1, 35.4),
                (.UnhealthySensitive, 35.5, 55.5),
                (.Unhealthy, 55.5, 150.4),
                (.VeryUnhealthy, 150.5, 250.4),
                (.Hazardous, 250.5, 500.4)
            ]
        }
    }
    
    public func maxVal() -> Double {
        switch self {
        case .PM_25:
            return self.aqiBreakpoints()[-1].max
        }
    }
}

public enum AqiCategory {
    case Good, Moderate, UnhealthySensitive, Unhealthy, VeryUnhealthy, Hazardous
    
    // https://www.airnow.gov/aqi/aqi-basics/
    public func scoreRange() -> (min: Int, max: Int) {
        switch self {
        case .Good:
            return (0, 50)
        case .Moderate:
            return (51, 100)
        case .UnhealthySensitive:
            return (101, 150)
        case .Unhealthy:
            return (151, 200)
        case .VeryUnhealthy:
            return (201, 300)
        case .Hazardous:
            return (301, 500)
        }
    }
    
    
    
    public func label() -> String {
        switch self {
        case .Good:
            return "Good"
        case .Moderate:
            return "Moderate"
        case .UnhealthySensitive:
            return "Unhealthy for Sensitive Groups"
        case .Unhealthy:
            return "Unhealthy"
        case .VeryUnhealthy:
            return "Very Unhealthy"
        case .Hazardous:
            return "Hazardous"
        }
    }
    
    public func color() -> String {
        // TODO: Replace with something more useful
        switch self {
            case .Good:
                return "Green"
            case .Moderate:
                return "Yellow"
            case .UnhealthySensitive:
                return "Orange"
            case .Unhealthy:
                return "Red"
            case .VeryUnhealthy:
                return "Purple"
            case .Hazardous:
                return "Maroon"

        }
    }
}

public struct AirQualityIndex {
    
    public enum AqiError: Error {
        case ConcentrationOutOfRange
    }
    
    public static func compute(forPollutant pollutant: Pollutant,
                               atConcentration concentration: Double) -> Result<(score: Int, category: AqiCategory),AqiError> {
        
        
        // step 1: for concentration, figure out which category bucket we are in:
        // aqiBreakpoints() returns things in sorted order, so .first() should work
        guard let targetCategory = pollutant.aqiBreakpoints().first(where: { $0.max > concentration }) else {
            // this should only happen if concentration is higher than the highest category's highest level, which is bad but also unlikely
            return .failure(.ConcentrationOutOfRange)
        }
        
        // terms for the equation:
        
        let c_low = targetCategory.min
        let c_high = targetCategory.max
        
        let i_low = Double(targetCategory.category.scoreRange().min)
        let i_high = Double(targetCategory.category.scoreRange().max)
        
        // the equation is as follows:
        // https://www.airnow.gov/sites/default/files/2018-05/aqi-technical-assistance-document-may2016.pdf
        // I = \frac{I_high - I_low}{C_high - C_low} (C - C_low) + I_low
        
        let part_1 = (i_high - i_low) / (c_high - c_low)
        let part_2 = (concentration - c_low)
        let i = part_1 * part_2 + i_low
        return .success(
            (Int(i.rounded()), targetCategory.category)
        )
        
    }
    
    
}
