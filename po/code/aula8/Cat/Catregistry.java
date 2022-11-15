package Cat;

import java.util.Map;
import java.util.TreeMap;
import java.util.Serializable;

public class Catregistry implements Serializable {
    private Map<String, Cat> _cats = new TreeMap<String, Cat>();

    public void put(Cat cat) {
        _cats.put(cat.getName(), cat);
    }

}
