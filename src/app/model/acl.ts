export class participant {
  primaryKey: string
  uid: string
  displayname: string
  type: number
}

export class acl {
  type: number
  boardId: number
  permissionEdit: boolean
  permissionShare: boolean
  permissionManage: boolean
  owner: boolean
  id: number
  participant: participant
}
