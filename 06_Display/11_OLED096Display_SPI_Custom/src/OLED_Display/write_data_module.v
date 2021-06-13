module write_data_module(
  input clk_1m,
  input RST_n,
  input write_data_start,
  
  output [3:0] spi_out,
  output write_done
);

wire spi_write_done;
wire spi_write_start;
wire [9:0] data_bus;
wire sys_RST_n;
assign sys_RST_n = RST_n;


wire [9:0]rom_addr;
wire [7:0]rom_data;
ROM u_ROM(
		.clock(clk_1m),
		.address(rom_addr),
		.q(rom_data)
		);

write_data u_write(
                .clk_1m(clk_1m),
                .RST_n(sys_RST_n),
                .write_data_start(write_data_start),
                .spi_write_done(spi_write_done),
				.rom_data(rom_data),
				
                .spi_write_start(spi_write_start),
                .write_done(write_done),
				.spi_data(data_bus),
				.rom_addr(rom_addr)
              );

spi_write u_spi(
                    .clk_1m(clk_1m),
                    .RST_n(sys_RST_n),
                    .spi_write_start(spi_write_start),
                    .spi_data(data_bus),
                    .spi_write_done(spi_write_done),
                    .spi_out(spi_out)
                    );
endmodule


