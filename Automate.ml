let reg_line = "^[^,;]+;[^,;]+\\(,[^,;]+\\)*$"
let regex = Str.regexp reg_line

let open_File file_name =
	try
		let fd = open_in file_name in
		Some fd
	with Sys_error msg ->
		print_endline ("Error : " ^ msg);
		None

let merge_Alphabet l1 l2 =
  List.fold_left (fun acc x ->
    if List.mem x acc then acc else x :: acc
  ) l1 l2

let train_Automate line automate alphabet =
	if not (Str.string_match regex line 0) then
		begin
			print_endline ("Error : '" ^ line ^ "' is malformated");
			(automate, alphabet)
		end
	else begin
	let split = Str.split (Str.regexp "[;,]") line in
	match split with
	| [] -> (automate, alphabet)
	| head :: tail ->
		let automate = Trie.add_node automate tail head in
		(automate, merge_Alphabet alphabet tail)
	end

let create_Automate file_name = 
	let automate = { Trie.children = []; values = [] } in
	let alphabet = [] in
	match open_File file_name with
	| None -> (automate, alphabet)
	| Some fd ->
		let rec read_Line automate alphabet =
			try
				let line = input_line fd in
				let (auto, alpha) = train_Automate line automate alphabet in
					read_Line auto alpha
		with End_of_file -> close_in fd;
			(automate, alphabet)
		in read_Line automate alphabet
