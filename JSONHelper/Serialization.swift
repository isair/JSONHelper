//
//  Copyright © 2016 Baris Sencan. All rights reserved.
//

import Foundation

/// TODOC
public protocol Serializable {

  /// TODOC
  func toDictionary() throws -> [String : Any]
}

// TODO
