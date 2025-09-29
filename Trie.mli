type 'a trie = {
	children : (string * 'a trie) list;
	values : 'a list;
}

val empty : 'a trie
val add_node : 'a trie -> string list -> 'a -> 'a trie
val next_state : 'a trie -> string -> 'a trie
