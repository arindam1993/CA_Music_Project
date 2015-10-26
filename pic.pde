// tools to save screen shots as .pdf files
import processing.pdf.*;    // to save screen shots as PDFs
boolean snapPic=false;
int pictureCounter=0;
String PicturesOutputPath="data/PDFimages";

void selectFolderForPDFs(File selection) {
  if (selection == null) println("Window was closed or the user hit cancel.");
  else PicturesOutputPath=selection.getAbsolutePath();
  println("    path to PDF image folder = "+PicturesOutputPath);
  }
