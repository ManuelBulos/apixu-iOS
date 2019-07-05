import Foundation

public class APIXU: NSObject {

    public typealias Callback<T: Codable> = (Result<T, Swift.Error>) -> Void

    // MARK: - Private properties

    fileprivate var key: String = String()

    /// Returns 'condition:text' field in API in the desired language.
    fileprivate var language: Language = .english

    /// Prints API response if set to true. False by default.
    fileprivate var debuggingEnabled: Bool = false

    /// URLSession object for APIXU instance.
    fileprivate let session: URLSession = URLSession(configuration: .default)

    // MARK: - Public functions

    /**
     Initializer
     - Parameter key: API Key.
     - Parameter language: Returns 'condition:text' field in API in the desired language.
     - Parameter debuggingEnabled: Prints API response if set to true. False by default.
     */
    public init(key: String, language: Language = .english, debuggingEnabled: Bool = false) {
        if key.isEmpty { fatalError("set value for APIXU.apiKey to start making requests") }
        self.key = key
        self.language = language
        self.debuggingEnabled = debuggingEnabled
    }

    // MARK: - SEARCH

    /**
     Calls search method.
     - Parameter query: Query object (coordinates or simple string).
     - Parameter completion: Callback<T: Codable> = (Result<T, Error>) -> Void.
     */
    public func search(matching query: Query, completion: @escaping Callback<[SearchResponse]>) {
        fetchData(from: .search,
                  matching: query,
                  objectToDecode: [SearchResponse].self,
                  completion: completion)
    }

    // MARK: - CURRENT WEATHER

    /**
     Calls current method.
     - Parameter query: Query object (coordinates or simple string).
     - Parameter completion: Callback<T: Codable> = (Result<T, Error>) -> Void
     */
    public func current(matching query: Query, completion: @escaping Callback<Response>) {
        fetchData(from: .currentWeather,
                  matching: query,
                  objectToDecode: Response.self,
                  completion: completion)
    }

    // MARK: - FORECAST

    /**
     Calls forecast method.
     - Parameter query: Query object (coordinates or simple string).

     - Parameter days: Number of days of forecast required.
     Value ranges between 1 and 10.e.g: days=5
     If no days parameter is provided then only today's weather is returned.

     - Parameter date: Restrict date output.
     Must be between today and next 10 day in yyyy-MM-dd format (i.e. dt=2015-01-01).

     - Parameter unixDate: Unix Timestamp.
     Same restriction as date parameter. Please either pass date or unixDate and not both in same request. e.g.: unixdt=1490227200

     - Parameter hour: Restrict output to a specific hour in a given day.
     Must be in 24 hour. For example 5 pm should be hour=17, 6 am as hour=6

     - Parameter completion: Callback<T: Codable> = (Result<T, Error>) -> Void
     */
    public func forecast(matching query: Query,
                  days: Int? = nil,
                  date: String? = nil,
                  unixDate: Int? = nil,
                  hour: Int? = nil,
                  completion: @escaping Callback<Response>) {
        fetchData(from: .forecast,
                  matching: query,
                  objectToDecode: Response.self,
                  days: days,
                  date: date,
                  unixDate: unixDate,
                  hour: hour,
                  completion: completion)
    }

    // MARK: - HISTORY

    /**
     Calls history method.
     - Parameter query: Query object (coordinates or simple string).

     - Parameter date: Restrict date output.
     Must be between today and next 10 day in yyyy-MM-dd format (i.e. dt=2015-01-01).

     - Parameter endDate: Restrict date output.
     Must be on or after 1st Jan, 2015 in yyyy-MM-dd format (i.e. dt=2015-01-01).
     Must be greater than endDate parameter and difference should not be more than 30 days between the two dates.
     Only works for API on Gold plan and above.

     - Parameter unixDate: Unix Timestamp.
     Same restriction as date parameter. Please either pass date or unixDate and not both in same request. e.g.: unixdt=1490227200

     - Parameter unixEndDate: Unix Timestamp.
     Same restriction as endDate parameter. Please either pass endDate or  unixEndDate and not both in same request. e.g.: unixend_dt=1490227200

     - Parameter hour: Restrict output to a specific hour in a given day.
     Must be in 24 hour. For example 5 pm should be hour=17, 6 am as hour=6

     - Parameter completion: Callback<T: Codable> = (Result<T, Error>) -> Void
     */
    public func history(matching query: Query,
                 date: String,
                 endDate: String? = nil,
                 unixDate: Int? = nil,
                 unixEndDate: Int? = nil,
                 hour: Int? = nil,
                 completion: @escaping Callback<Response>) {
        fetchData(from: .history,
                  matching: query,
                  objectToDecode: Response.self,
                  date: date,
                  endDate: endDate,
                  unixDate: unixDate,
                  unixEndDate: unixEndDate,
                  hour: hour,
                  completion: completion)
    }

    // MARK: - Private functions

    fileprivate func fetchData<T: Codable>(from method: Method,
                                           matching query: Query,
                                           objectToDecode: T.Type,
                                           days: Int? = nil,
                                           date: String? = nil,
                                           endDate: String? = nil,
                                           unixDate: Int? = nil,
                                           unixEndDate: Int? = nil,
                                           hour: Int? = nil,
                                           completion: @escaping Callback<T>) {

        let queryItems = buildQueryItems(from: query,
                                         days: days,
                                         date: date,
                                         endDate: endDate,
                                         unixDate: unixDate,
                                         unixEndDate: unixEndDate,
                                         hour: hour)

        callAPIXU(method: method, queryItems: queryItems) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        completion(.success(try JSONDecoder().decode(objectToDecode, from: data)))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    fileprivate func buildQueryItems(from query: Query,
                                     days: Int? = nil,
                                     date: String? = nil,
                                     endDate: String? = nil,
                                     unixDate: Int? = nil,
                                     unixEndDate: Int? = nil,
                                     hour: Int? = nil) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = [URLQueryItem]()

        let queryItemKey: URLQueryItem = URLQueryItem(name: "key", value: key)

        let queryItemQuery: URLQueryItem = URLQueryItem(name: "q", value: query.value)

        let queryItemLanguage: URLQueryItem = URLQueryItem(name: "lang", value: language.rawValue)

        queryItems.append(contentsOf: [queryItemKey, queryItemQuery, queryItemLanguage])

        if let days = days {
            let queryItemDays: URLQueryItem = URLQueryItem(name: "days", value: String(days))
            queryItems.append(queryItemDays)
        }

        if let date = date {
            let queryItemDate: URLQueryItem = URLQueryItem(name: "dt", value: date)
            queryItems.append(queryItemDate)
        }

        if let endDate = endDate {
            let queryItemEndDate: URLQueryItem = URLQueryItem(name: "end_dt", value: endDate)
            queryItems.append(queryItemEndDate)
        }

        if let unixDate = unixDate {
            let queryItemUnixDate: URLQueryItem = URLQueryItem(name: "unixdt", value: String(unixDate))
            queryItems.append(queryItemUnixDate)
        }

        if let unixEndDate = unixEndDate {
            let queryItemUnixEndDate: URLQueryItem = URLQueryItem(name: "unixend_dt", value: String(unixEndDate))
            queryItems.append(queryItemUnixEndDate)
        }

        if let hour = hour {
            let queryItemHour: URLQueryItem = URLQueryItem(name: "hour", value: String(hour))
            queryItems.append(queryItemHour)
        }

        return queryItems
    }

    fileprivate func callAPIXU(method: Method,
                               queryItems: [URLQueryItem],
                               completion: @escaping Callback<Data>) {
        guard var baseURL: URL = URL(string: Constants.baseURL) else {
            completion(.failure(Error.invalidURL))
            return
        }

        baseURL.appendPathComponent(method.rawValue)

        guard var components: URLComponents = URLComponents(string: baseURL.absoluteString) else {
            completion(.failure(Error.invalidURL))
            return
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            completion(.failure(Error.invalidURL))
            return
        }

        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                if self.debuggingEnabled { print(String(data: data, encoding: .utf8) ?? String()) }
                completion(.success(data))
            } else {
                completion(.failure(Error.invalidData))
            }
        }.resume()
    }
}
