public class Application {
	public static void main(String[] args) {
		Cat cat = new Cat("Tareco", 12, 3.141);
		System.out.println(cat.equals(new Cat("Tareco", 12, 3.141)));
		System.out.println(cat.equals(new Cat("Pantufa", 12, 3.141)));
		System.out.println(cat);
	}
}
