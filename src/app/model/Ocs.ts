import { Upcoming } from "@app/model/upcoming";

export class Ocs {
  ocs : {
    meta: OCSMetadata
    data: Upcoming[]
  }
}

export class OCSMetadata {
    status: string
    statuscode: number
    message: string
}

export class Capabilities {
  ocs: {
    meta: OCSMetadata
    data: {
      version: {
        major: number
        minor: number
        micro: number
        string: string
        edition: string
        extendedSupport: boolean
      }
      capabilities: {
        deck: {
          version: string
          canCreateBoards: boolean
          apiVersions: string[]
        }
      }
    }
  }
}
