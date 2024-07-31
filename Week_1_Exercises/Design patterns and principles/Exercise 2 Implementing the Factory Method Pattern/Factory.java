
public class WordDocument implements Factory {
    public void open() {
        System.out.println("Word Document opened..");
    }

    public void close() {
        System.out.println("Word Document colsed...");
    }
}

public class PdfDocument implements Factory {
    public void open() {
        System.out.println("Pdf Document opened..");
    }

    public void close() {
        System.out.println("Pdf Document colsed...");
    }
}

public abstract class DocumentFactory {
    public abstract Factory createDocument();
}

public class WordDocumentFactory extends DocumentFactory {
    public Factory createDocument() {
        return new WordDocument();
    }
}

public class PdfDocumentFactory extends DocumentFactory {
    public Factory createDocument() {
        return new WordDocument();
    }
}

public class FactoryMethodtest {

    public static void main(String[] args) {
        DocumentFactory wordFactory = new WordDocumentFactory();
        Factory wordDoc = wordFactory.createDocument();
        wordDoc.open();
        wordDoc.close();
        DocumentFactory pdfFactory = new PdfDocumentFactory();
        Factory pdfDoc = pdfFactory.createDocument();
        pdfDoc.open();
        pdfDoc.close();
    }
}
