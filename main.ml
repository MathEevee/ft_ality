let check_Arg argv =
	let argc = Array.length argv in
	if argc = 1 then
		begin
			Print.print_Error "Usage : ./ft_ality <grammar_file>";
			false
		end
	else if argc > 2 then
		begin
			Print.print_Error "Error : Too many arguments";
			false
		end
	else
		true

let init_Window width height =
	match Tsdl.Sdl.init Tsdl.Sdl.Init.video with
	| Error (`Msg e) -> Print.print_Error ("Erreur SDL :" ^ e); 
		exit 1
	| Ok () -> ();

	match Tsdl.Sdl.create_window
		~w:width
		~h:height
		"Keyboard Window"
		Tsdl.Sdl.Window.shown
	with
	| Error (`Msg e) -> Print.print_Error ("Erreur SDL :" ^ e);
		exit 1
	| Ok win -> win


let launch_Automate automate key_mapping =
	let rec in_Automate curr_state alphabet move_list =
		match Keyboard.key_Loop () with
		| None -> ()
		| Some key ->
			match List.assoc_opt key key_mapping with
			| None -> 
				Print.print_Error ("This key : " ^ (Tsdl.Sdl.get_key_name key) ^ " doesn't bind.");
				in_Automate automate alphabet ""
			| Some sym ->
				let curr_state = Trie.next_state curr_state sym in
				let move_list = move_list ^ " | " ^ sym in
				print_endline move_list;
				List.iter print_endline curr_state.values;
				if curr_state.children = [] then
					in_Automate automate alphabet ""
				else
					in_Automate curr_state alphabet move_list

	in 
	in_Automate automate key_mapping ""

let () =
	let argv = Sys.argv in
	if not (check_Arg argv) then 
		exit 1;

	let (automate, alphabet) = Automate.create_Automate argv.(1) in
	if alphabet = [] then
		exit 1;

	let window = init_Window 400 200 in	

	match Keyboard.create_Key_Mapping alphabet with
	| None ->
			Tsdl.Sdl.destroy_window window;
			Tsdl.Sdl.quit ()
	| Some key_mapping ->
		Print.print_Key_Mapping key_mapping;
		
		
		(*let key_map = key_Mapping alphabet in
		List.iter print_endline key_map;*)
		
	launch_Automate automate key_mapping;
		
	Tsdl.Sdl.destroy_window window;
	Tsdl.Sdl.quit ()
	(*let next_a = Trie.next_state automate " a" in
		List.iter print_endline next_a.values;
	print_endline "";
		let end_b = Trie.next_state next_a " b" in
		List.iter print_endline end_b.values;
	print_endline "";
	let end_a = Trie.next_state end_b " a" in
		List.iter print_endline end_a.values;
	print_endline "";*)
