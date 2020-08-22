using Test
using JuliaFormatter

format("src/")

#= Simple (and dumb) script to check solutions =#

Solutions = (
("euler_001.jl", "233168"),
("euler_002.jl", "4613732"),
("euler_003.jl", "6857"),
("euler_004.jl", "906609"),
("euler_005.jl", "232792560"),
("euler_006.jl", "25164150"),
("euler_007.jl", "104743"),
("euler_008.jl", "23514624000"),
("euler_009.jl", "31875000"),
("euler_010.jl", "142913828922"),
("euler_011.jl", "70600674"),
("euler_012.jl", "76576500"),
("euler_013.jl", "5537376230"),
("euler_014.jl", "837799"),
("euler_015.jl", "137846528820"),
("euler_016.jl", "1366"),
("euler_017.jl", "21124"),
("euler_018.jl", "1074"),
("euler_019.jl", "171"),
("euler_020.jl", "648"),
("euler_021.jl", "31626"),
("euler_022.jl", "871198282"),
("euler_023.jl", "4179871"),
("euler_024.jl", "2783915460"),
("euler_025.jl", "4782"),
("euler_026.jl", "983"),
("euler_027.jl", "-59231"),
("euler_028.jl", "669171001"),
("euler_029.jl", "9183"),
("euler_030.jl", "443839"),
("euler_031.jl", "73682"),
("euler_032.jl", "45228"),
("euler_033.jl", "100"),
("euler_034.jl", "40730"),
("euler_035.jl", "55"),
("euler_036.jl", "872187"),
("euler_037.jl", "748317"),
("euler_038.jl", "932718654"),
("euler_039.jl", "840"),
)

for (filename, solution) in Solutions
    @test read(`julia src/$filename`, String) == solution
    println("$filename -- OK")
end

