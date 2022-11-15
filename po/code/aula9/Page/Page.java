package Page;

import java.util.List;
import java.util.spi.ResourceBundleProvider;
import java.util.ArrayList;

public class Page extends PageElement {
    private List<PageElement> _elements = new ArrayList<PageElement>();

    public void addPage(Page p) {
        _elements.add(p);
    }

    public void addParagraph(Paragraph p) {
        _elements.add(p);
    }

    public void removeElement(PageElement e) {
        _elements.remove(e);
    }

    @Override
    public String render() {
        String rendered = "<page\n";

        for (PageElement e : _elements) {
            rendered += e.render() + "\n";
        }
        return rendered + "</page>";
    }
}
