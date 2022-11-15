package Page;

import java.util.List;
import java.util.ArrayList;

public class Paragraph extends PageElement {
    private List<PageElement> _elements = new ArrayList<PageElement>();

    public void addElement(PageElement e) {
        _elements.add(e);
    }

    public void removeElement(PageElement e) {
        _elements.remove(e);
    }

    @Override
    public String render() {
        String rendered = "<p>\n";

        for (PageElement e : _elements) {
            rendered += e.render() + "\n";
        }
        return rendered + "</p>" + "\n";
    }

}
