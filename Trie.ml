type 'a trie = {
		children : (string * 'a trie) list;
		values : 'a list;
}

let empty = { children = []; values = [] }

let rec add_node trie combination res_combination =
	match combination with
	| [] -> { trie with values = res_combination :: trie.values }
	| head :: tail ->
		let child =
			match List.assoc_opt head trie.children with
			| Some t -> t
			| None -> empty
		in
			let child_trie = add_node child tail res_combination in
			let new_children = (head, child_trie) :: List.remove_assoc head trie.children
			in { trie with children = new_children }

let next_state trie symbol =
	match List.assoc_opt symbol trie.children with
		| Some t -> t
		| None -> empty
