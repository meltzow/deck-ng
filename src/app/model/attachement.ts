export interface Attachement {
  cardId: number,
  type: string,
  data: string,
  lastModified: number,
  createdAt: number,
  createdBy: string,
  deletedAt: number,
  extendedData: {
    filesize: number,
    mimetype: string
    info: {
      dirname: string,
      basename: string,
      extension: string,
      filename: string
    }
  },
  id: number
}
