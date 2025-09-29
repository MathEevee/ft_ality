let open_File file_name =
	try
		let fd = open_in file_name in
		Some fd
	with Sys_error msg ->
		print_endline ("Error : " ^ msg);
		None

let train_Automate line automate =
	(* Parse la line *)
	let split = String.split_on_char ';' line in
	match split with
	| [] -> automate
	| head :: tail ->
		let automate = Trie.add_node automate (String.split_on_char ',' (List.hd tail)) head in
		automate

let create_Automate file_name = 
	let automate = { Trie.children = []; values = [] } in
	match open_File file_name with
	| None -> automate
	| Some fd ->
		let rec read_line automate =
			try
				let line = input_line fd in
				read_line (train_Automate line automate)
		with End_of_file -> close_in fd;
			automate
		in read_line automate
