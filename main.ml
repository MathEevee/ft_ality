let check_Arg argv =

	let argc = Array.length argv in
	if argc = 1 then
		begin
			print_endline "Usage : ./ft_ality <grammar_file>";
			false
		end
	else if argc > 2 then
		begin
			print_endline "Error : Too many arguments";
			false
		end
	else
		true

let () =
	
	let argv = Sys.argv in
	if not (check_Arg argv) then 
		exit 1;

	(*let automate = { Trie.children = []; values = [] } in
	let automate = train_Automate fd automate in*)
	
	let automate = Automate.create_Automate argv.(1) in
	List.iter print_endline automate.values;
	let next_a = Trie.next_state automate " a" in
    List.iter print_endline next_a.values;
	print_endline "";
    let end_b = Trie.next_state next_a " b" in
    List.iter print_endline end_b.values;
	print_endline "";
	let end_a = Trie.next_state end_b " a" in
    List.iter print_endline end_a.values;
	print_endline "";
