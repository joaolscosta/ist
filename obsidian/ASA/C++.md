	1
> [!INFO] vector
> 
```cpp
vector<int> v; // v = {}
cout << v.size () << endl; // outputs 0
v.pushback(20); // v = {20}
v.pushback(10); // v = {20, 10}
v.pushback(10); // v = {20, 10, 10}
cout << v[1] << endl; // outputs 10
cout << v.size () < endl; // outputs 3
```

# Data Structures

> [!INFO] set
> Armazena por ordem e não contem elementos repetidos
```cpp
set<int> s; // s = {}
s.insert (20); // s = {20}
s.insert (10); // s = {10, 20}
s.insert (10); // s = {10, 20}
auto it = s.find (10); // iterator that poins to 10
cout << (it != s.end () ? "FOUND" : "") << endl; // outputs FOUND
cout << s.size () << endl; // outputs 2
```


> [!INFO] unordered_set
> Mesma coisa que o set mas pode estar em qualquer ordem


> [!INFO] map
> Armazena {(key, value)}
```cpp
map<int, int> m; // m = {}
m.insert (make_pair(20, 1)); // m = {(20, 1)}
m.insert (make_pair(10, 1)); // m = {(10, 1), (20, 1)}
m[10]++; // m = {(10, 2), (20, 1)}
auto it = m.find(20); // iterator that points to (10, 2)
cout << (it != m.end() ? it->sencond : 0) << endl; // outputs 2
auto it2 = m.find(20); // iterator that points to (20, 1)
cout << it2 != m.end() ? it2->first : 0) << endl; // outputs 20
cout << m.size() << endl;
```


> [!INFO] unordered_map
> Mesma coisa que o map mas pode estar em qualquer ordem


# Good Practise

```cpp
using namespace std;
using std::string, std::coutm std::endl;
```

- Em ciclos em vez de usar `... << std::endl;`  usar `"\n"`.

```cpp
for(std:size_t i = 0; i < data.size(); i++)
for(const auto x: data)
```

- find_if()
- at()

```cpp
for(auto pair: colors) {
	std::out << "name: " << pair.first << ", hex: " << pair.second << "\n";
}

for(auto[name, hex]: colors){
	std::cout << "name: " << name << ", hex: " << hex << "\n";
}

```


> [!TIP] Keywords
>  - class por omissão é privada e struct público

```cpp
COMPILAR
g++ -std=c++20 -Wall -Wextra -pedantic -c <ficheiro>
```

