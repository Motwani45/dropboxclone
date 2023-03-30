enum FileEnum{
  NotUploaded("Not Uploaded"),
  UploadInProgress("Upload In Progress"),
  UploadComplete("Upload Complete"),
  UploadFailed("Upload Failed");

  final String message;
  const FileEnum(this.message);
}