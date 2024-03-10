library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_rom2 is
generic	(
	ADDR_WIDTH : integer := 8; -- ROM's address width (words, not bytes)
	COL_WIDTH  : integer := 8;  -- Column width (8bit -> byte)
	NB_COL     : integer := 4  -- Number of columns in memory
	);
port (
	clk : in std_logic;
	reset_n : in std_logic := '1';
	addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
	q : out std_logic_vector(31 downto 0);
	-- Allow writes - defaults supplied to simplify projects that don't need to write.
	d : in std_logic_vector(31 downto 0) := X"00000000";
	we : in std_logic := '0';
	bytesel : in std_logic_vector(3 downto 0) := "1111"
);
end entity;

architecture arch of controller_rom2 is

-- type word_t is std_logic_vector(31 downto 0);
type ram_type is array (0 to 2 ** ADDR_WIDTH - 1) of std_logic_vector(NB_COL * COL_WIDTH - 1 downto 0);

signal ram : ram_type :=
(

     0 => x"aab7c04a",
     1 => x"c287d303",
     2 => x"05bfcdcd",
     3 => x"4bc187c4",
     4 => x"4bc087c2",
     5 => x"5bd1cdc2",
     6 => x"cdc287c4",
     7 => x"cdc25ad1",
     8 => x"c14abfcd",
     9 => x"a2c0c19a",
    10 => x"87e8ec49",
    11 => x"cdc248fc",
    12 => x"fe78bfcd",
    13 => x"711e87ef",
    14 => x"1e66c44a",
    15 => x"fde94972",
    16 => x"4f262687",
    17 => x"cdcdc21e",
    18 => x"d7e649bf",
    19 => x"d6ecc287",
    20 => x"78bfe848",
    21 => x"48d2ecc2",
    22 => x"c278bfec",
    23 => x"4abfd6ec",
    24 => x"99ffc349",
    25 => x"722ab7c8",
    26 => x"c2b07148",
    27 => x"2658deec",
    28 => x"5b5e0e4f",
    29 => x"710e5d5c",
    30 => x"87c8ff4b",
    31 => x"48d1ecc2",
    32 => x"497350c0",
    33 => x"7087fde5",
    34 => x"9cc24c49",
    35 => x"cb49eecb",
    36 => x"497087c3",
    37 => x"d1ecc24d",
    38 => x"c105bf97",
    39 => x"66d087e2",
    40 => x"daecc249",
    41 => x"d60599bf",
    42 => x"4966d487",
    43 => x"bfd2ecc2",
    44 => x"87cb0599",
    45 => x"cbe54973",
    46 => x"02987087",
    47 => x"c187c1c1",
    48 => x"87c0fe4c",
    49 => x"d8ca4975",
    50 => x"02987087",
    51 => x"ecc287c6",
    52 => x"50c148d1",
    53 => x"97d1ecc2",
    54 => x"e3c005bf",
    55 => x"daecc287",
    56 => x"66d049bf",
    57 => x"d6ff0599",
    58 => x"d2ecc287",
    59 => x"66d449bf",
    60 => x"caff0599",
    61 => x"e4497387",
    62 => x"987087ca",
    63 => x"87fffe05",
    64 => x"dcfb4874",
    65 => x"5b5e0e87",
    66 => x"f40e5d5c",
    67 => x"4c4dc086",
    68 => x"c47ebfec",
    69 => x"ecc248a6",
    70 => x"c178bfde",
    71 => x"c71ec01e",
    72 => x"87cdfd49",
    73 => x"987086c8",
    74 => x"ff87cd02",
    75 => x"87ccfb49",
    76 => x"e349dac1",
    77 => x"4dc187ce",
    78 => x"97d1ecc2",
    79 => x"87c302bf",
    80 => x"c287fed4",
    81 => x"4bbfd6ec",
    82 => x"bfcdcdc2",
    83 => x"87e9c005",
    84 => x"e249fdc3",
    85 => x"fac387ee",
    86 => x"87e8e249",
    87 => x"ffc34973",
    88 => x"c01e7199",
    89 => x"87cefb49",
    90 => x"b7c84973",
    91 => x"c11e7129",
    92 => x"87c2fb49",
    93 => x"fac586c8",
    94 => x"daecc287",
    95 => x"029b4bbf",
    96 => x"cdc287dd",
    97 => x"c749bfc9",
    98 => x"987087d7",
    99 => x"c087c405",
   100 => x"c287d24b",
   101 => x"fcc649e0",
   102 => x"cdcdc287",
   103 => x"c287c658",
   104 => x"c048c9cd",
   105 => x"c2497378",
   106 => x"87cd0599",
   107 => x"e149ebc3",
   108 => x"497087d2",
   109 => x"c20299c2",
   110 => x"734cfb87",
   111 => x"0599c149",
   112 => x"f4c387cd",
   113 => x"87fce049",
   114 => x"99c24970",
   115 => x"fa87c202",
   116 => x"c849734c",
   117 => x"87cd0599",
   118 => x"e049f5c3",
   119 => x"497087e6",
   120 => x"d40299c2",
   121 => x"e2ecc287",
   122 => x"87c902bf",
   123 => x"c288c148",
   124 => x"c258e6ec",
   125 => x"c14cff87",
   126 => x"c449734d",
   127 => x"87ce0599",
   128 => x"ff49f2c3",
   129 => x"7087fddf",
   130 => x"0299c249",
   131 => x"ecc287db",
   132 => x"487ebfe2",
   133 => x"03a8b7c7",
   134 => x"486e87cb",
   135 => x"ecc280c1",
   136 => x"c2c058e6",
   137 => x"c14cfe87",
   138 => x"49fdc34d",
   139 => x"87d4dfff",
   140 => x"99c24970",
   141 => x"c287d502",
   142 => x"02bfe2ec",
   143 => x"c287c9c0",
   144 => x"c048e2ec",
   145 => x"87c2c078",
   146 => x"4dc14cfd",
   147 => x"ff49fac3",
   148 => x"7087f1de",
   149 => x"0299c249",
   150 => x"ecc287d9",
   151 => x"c748bfe2",
   152 => x"c003a8b7",
   153 => x"ecc287c9",
   154 => x"78c748e2",
   155 => x"fc87c2c0",
   156 => x"c04dc14c",
   157 => x"c003acb7",
   158 => x"66c487d1",
   159 => x"82d8c14a",
   160 => x"c6c0026a",
   161 => x"744b6a87",
   162 => x"c00f7349",
   163 => x"1ef0c31e",
   164 => x"f749dac1",
   165 => x"86c887db",
   166 => x"c0029870",
   167 => x"a6c887e2",
   168 => x"e2ecc248",
   169 => x"66c878bf",
   170 => x"c491cb49",
   171 => x"80714866",
   172 => x"bf6e7e70",
   173 => x"87c8c002",
   174 => x"c84bbf6e",
   175 => x"0f734966",
   176 => x"c0029d75",
   177 => x"ecc287c8",
   178 => x"f349bfe2",
   179 => x"cdc287c9",
   180 => x"c002bfd1",
   181 => x"c24987dd",
   182 => x"987087c7",
   183 => x"87d3c002",
   184 => x"bfe2ecc2",
   185 => x"87eff249",
   186 => x"cff449c0",
   187 => x"d1cdc287",
   188 => x"f478c048",
   189 => x"87e9f38e",
   190 => x"5c5b5e0e",
   191 => x"711e0e5d",
   192 => x"deecc24c",
   193 => x"cdc149bf",
   194 => x"d1c14da1",
   195 => x"747e6981",
   196 => x"87cf029c",
   197 => x"744ba5c4",
   198 => x"deecc27b",
   199 => x"c8f349bf",
   200 => x"747b6e87",
   201 => x"87c4059c",
   202 => x"87c24bc0",
   203 => x"49734bc1",
   204 => x"d487c9f3",
   205 => x"87c70266",
   206 => x"7087da49",
   207 => x"c087c24a",
   208 => x"d5cdc24a",
   209 => x"d8f2265a",
   210 => x"00000087",
   211 => x"00000000",
   212 => x"00000000",
   213 => x"4a711e00",
   214 => x"49bfc8ff",
   215 => x"2648a172",
   216 => x"c8ff1e4f",
   217 => x"c0fe89bf",
   218 => x"c0c0c0c0",
   219 => x"87c401a9",
   220 => x"87c24ac0",
   221 => x"48724ac1",
   222 => x"5e0e4f26",
   223 => x"0e5d5c5b",
   224 => x"d4ff4b71",
   225 => x"4866d04c",
   226 => x"49d678c0",
   227 => x"87f4dbff",
   228 => x"6c7cffc3",
   229 => x"99ffc349",
   230 => x"c3494d71",
   231 => x"e0c199f0",
   232 => x"87cb05a9",
   233 => x"6c7cffc3",
   234 => x"d098c348",
   235 => x"c3780866",
   236 => x"4a6c7cff",
   237 => x"c331c849",
   238 => x"4a6c7cff",
   239 => x"4972b271",
   240 => x"ffc331c8",
   241 => x"714a6c7c",
   242 => x"c84972b2",
   243 => x"7cffc331",
   244 => x"b2714a6c",
   245 => x"c048d0ff",
   246 => x"9b7378e0",
   247 => x"7287c202",
   248 => x"2648757b",
   249 => x"264c264d",
   250 => x"1e4f264b",
   251 => x"5e0e4f26",
   252 => x"f80e5c5b",
   253 => x"c81e7686",
   254 => x"fdfd49a6",
   255 => x"7086c487",
   256 => x"c0486e4b",
   257 => x"c6c301a8",
   258 => x"c34a7387",
   259 => x"d0c19af0",
   260 => x"87c702aa",
   261 => x"05aae0c1",
   262 => x"7387f4c2",
   263 => x"0299c849",
   264 => x"c6ff87c3",
   265 => x"c34c7387",
   266 => x"05acc29c",
   267 => x"c487cdc1",
   268 => x"31c94966",
   269 => x"66c41e71",
   270 => x"c292d44a",
   271 => x"7249e6ec",
   272 => x"e0d5fe81",
   273 => x"4966c487",
   274 => x"49e3c01e",
   275 => x"87d9d9ff",
   276 => x"d8ff49d8",
   277 => x"c0c887ee",
   278 => x"d6dbc21e",
   279 => x"f5f1fd49",
   280 => x"48d0ff87",
   281 => x"c278e0c0",
   282 => x"d01ed6db",
   283 => x"92d44a66",
   284 => x"49e6ecc2",
   285 => x"d3fe8172",
   286 => x"86d087e8",
   287 => x"c105acc1",
   288 => x"66c487cd",
   289 => x"7131c949",
   290 => x"4a66c41e",
   291 => x"ecc292d4",
   292 => x"817249e6",
   293 => x"87cdd4fe",
   294 => x"1ed6dbc2",
   295 => x"d44a66c8",
   296 => x"e6ecc292",
   297 => x"fe817249",
   298 => x"c887f4d1",
   299 => x"c01e4966",
   300 => x"d7ff49e3",
   301 => x"49d787f3",
   302 => x"87c8d7ff",
   303 => x"c21ec0c8",
   304 => x"fd49d6db",
   305 => x"d087feef",
   306 => x"48d0ff86",
   307 => x"f878e0c0",
   308 => x"87d1fc8e",
   309 => x"5c5b5e0e",
   310 => x"711e0e5d",
   311 => x"4cd4ff4d",
   312 => x"487e66d4",
   313 => x"06a8b7c3",
   314 => x"48c087c5",
   315 => x"7587e2c1",
   316 => x"c1e2fe49",
   317 => x"c41e7587",
   318 => x"93d44b66",
   319 => x"83e6ecc2",
   320 => x"ccfe4973",
   321 => x"83c887fd",
   322 => x"d0ff4b6b",
   323 => x"78e1c848",
   324 => x"49737cdd",
   325 => x"7199ffc3",
   326 => x"c849737c",
   327 => x"ffc329b7",
   328 => x"737c7199",
   329 => x"29b7d049",
   330 => x"7199ffc3",
   331 => x"d849737c",
   332 => x"7c7129b7",
   333 => x"7c7c7cc0",
   334 => x"7c7c7c7c",
   335 => x"7c7c7c7c",
   336 => x"78e0c07c",
   337 => x"dc1e66c4",
   338 => x"dcd5ff49",
   339 => x"7386c887",
   340 => x"cefa2648",
   341 => x"5b5e0e87",
   342 => x"1e0e5d5c",
   343 => x"d4ff7e71",
   344 => x"c21e6e4b",
   345 => x"fe49faec",
   346 => x"c487d8cb",
   347 => x"9d4d7086",
   348 => x"87c3c302",
   349 => x"bfc2edc2",
   350 => x"fe496e4c",
   351 => x"ff87f7df",
   352 => x"c5c848d0",
   353 => x"7bd6c178",
   354 => x"7b154ac0",
   355 => x"e0c082c1",
   356 => x"f504aab7",
   357 => x"48d0ff87",
   358 => x"c5c878c4",
   359 => x"7bd3c178",
   360 => x"78c47bc1",
   361 => x"c1029c74",
   362 => x"dbc287fc",
   363 => x"c0c87ed6",
   364 => x"b7c08c4d",
   365 => x"87c603ac",
   366 => x"4da4c0c8",
   367 => x"e8c24cc0",
   368 => x"49bf97c7",
   369 => x"d20299d0",
   370 => x"c21ec087",
   371 => x"fe49faec",
   372 => x"c487cccd",
   373 => x"4a497086",
   374 => x"c287efc0",
   375 => x"c21ed6db",
   376 => x"fe49faec",
   377 => x"c487f8cc",
   378 => x"4a497086",
   379 => x"c848d0ff",
   380 => x"d4c178c5",
   381 => x"bf976e7b",
   382 => x"c1486e7b",
   383 => x"c17e7080",
   384 => x"f0ff058d",
   385 => x"48d0ff87",
   386 => x"9a7278c4",
   387 => x"c087c505",
   388 => x"87e5c048",
   389 => x"ecc21ec1",
   390 => x"cafe49fa",
   391 => x"86c487e0",
   392 => x"fe059c74",
   393 => x"d0ff87c4",
   394 => x"78c5c848",
   395 => x"c07bd3c1",
   396 => x"c178c47b",
   397 => x"c087c248",
   398 => x"4d262648",
   399 => x"4b264c26",
   400 => x"5e0e4f26",
   401 => x"710e5c5b",
   402 => x"0266cc4b",
   403 => x"c04c87d8",
   404 => x"d8028cf0",
   405 => x"c14a7487",
   406 => x"87d1028a",
   407 => x"87cd028a",
   408 => x"87c9028a",
   409 => x"497387d7",
   410 => x"d087eafb",
   411 => x"c01e7487",
   412 => x"87e0f949",
   413 => x"49731e74",
   414 => x"c887d9f9",
   415 => x"87fcfe86",
   416 => x"dac21e00",
   417 => x"c149bfea",
   418 => x"eedac2b9",
   419 => x"48d4ff59",
   420 => x"ff78ffc3",
   421 => x"e1c848d0",
   422 => x"48d4ff78",
   423 => x"31c478c1",
   424 => x"d0ff7871",
   425 => x"78e0c048",
   426 => x"00004f26",
   427 => x"00000000",
  others => ( x"00000000")
);

-- Xilinx Vivado attributes
attribute ram_style: string;
attribute ram_style of ram: signal is "block";

signal q_local : std_logic_vector((NB_COL * COL_WIDTH)-1 downto 0);

signal wea : std_logic_vector(NB_COL - 1 downto 0);

begin

	output:
	for i in 0 to NB_COL - 1 generate
		q((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= q_local((i+1) * COL_WIDTH - 1 downto i * COL_WIDTH);
	end generate;
    
    -- Generate write enable signals
    -- The Block ram generator doesn't like it when the compare is done in the if statement it self.
    wea <= bytesel when we = '1' else (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            q_local <= ram(to_integer(unsigned(addr)));
            for i in 0 to NB_COL - 1 loop
                if (wea(NB_COL-i-1) = '1') then
                    ram(to_integer(unsigned(addr)))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= d((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                end if;
            end loop;
        end if;
    end process;

end arch;
