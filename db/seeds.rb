# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([[ {name: 'Star Wars'} ], [ {name: 'Lord of the Rings'] }])
#   Character.create(name: 'Luke', movie: movies.first)

# Patient.create(name: 'Test User', email: 'test@email.com', mobile: '9000000000')

coupon_list = [
    # [ "SODELHIXAPA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHDWB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHITWA7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKYHQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5F53", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQX5U", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZ4YP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQ2PD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMJ7S", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIA2JW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIL2Z9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIP5VR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIE7KX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3S7K", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBJNX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMYWE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFZVU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICLW5", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7FQK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISFB4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHR2K", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMRAD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICPP2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI77Y3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDW74", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVCJJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5W89", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMBJL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAN9T", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINC3B", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWPQL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI52EF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRCEH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYQ48", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISCNK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISERV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6U3X", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9HP2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPEEA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEV7S", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXSLR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIG7NJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI84CA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKTDB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9N3G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISKCC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEFRB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILPRJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXG7G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4ZF9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7AC7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2YJZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9SAQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMGKW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEPKE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFK87", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIU6F5", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILMUC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDEA3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJRFM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9D4L", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHID6EP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7C7Y", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5F9A", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISMHW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ4FN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5KWC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIB2LK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIX44T", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFL4V", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHWV2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6KHG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4J5C", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJRWM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZ9C8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIY92Q", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGSED", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGGPR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ4RC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIM3YQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINFVX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDRPQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9SDU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2VWB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQGEH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJYC4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEFHZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4W26", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKSKM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI73BU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ3GN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIF2QC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZRPL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWAGY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIALKT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUJGJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKB37", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJT5D", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIER4F", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQR9W", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIY5HT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ7DZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUTXK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPQCV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4E6X", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUKA3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZUUN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVQE9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI64QW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJJKC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHBCM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8BZT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUB8N", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYMSE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2J6N", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRBS4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIA2PM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI63FX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4EUR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7C99", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINWGF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHT3Y", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI55GQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2TME", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKZ4M", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2HSZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4Z59", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIW8ZS", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5ZHT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUMP7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMENG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISCQX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBF59", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFCKD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGT3Y", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8DEX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIW7T6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISBPH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVP88", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPQLT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXC3U", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFV4T", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAGTU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUHCZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICC3P", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9HZD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXQLW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGUS4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILKY3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9Y2K", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZCZE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILYNT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ52K", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXD36", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIE8JH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIU828", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJWCE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9AK7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICXXN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQ8XQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3GQX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRBST", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4CV9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7PQG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2LTN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKS48", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIU8LT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHD5A", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUDV5", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIR5ZM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYBZM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKRD2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZFGG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6QF5", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICM4T", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIW5VP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3VCG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIX2ZV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5TXD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4YSA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVQYH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINE76", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIH27G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZYD7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIG9FZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7PCK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIX35E", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFGEN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRNGA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8PXL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT44K", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZXQ8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIB7TQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIX7XU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAC79", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJYH9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9X97", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIU5JE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISYLB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICM9T", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZXEC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRZ5H", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9JSL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAA3G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRLDW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8L9G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIS3CP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIY4MB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT3FY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISRM2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPL92", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRTEG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5UMQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI67ZM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQFZ3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKZSQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ7NK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIF9K7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT5RJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI224R", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINJC7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXRJD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBKQQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJQTS", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXD7Y", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINQN4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIF9S9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9XCF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILMRT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJJ5L", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6LLJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBFT2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFQGP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIG3MR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICGE7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISEWH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIB3RK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINUFH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIP983", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZLN7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIY5LQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIN5WV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPB8B", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAHN7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI25UR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBJTQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRUBK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8RQ6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYG4H", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQSXB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFSPE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICEMX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDFRU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHITEB6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXY97", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT3Q3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHF6Q", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI952Q", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIE5A7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4LVF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2JAE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDJ9R", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZP89", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHF83", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI67A9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWG67", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINDAX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPUWL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPFTD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHITUSY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIM2H9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIL56Q", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT8DN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIU9QQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI24UC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYSD4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZDFV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYQ9F", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5ELY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBKJZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRY9H", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRQV2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT92L", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICDAV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIB2SZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWN3D", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZRR6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4KL9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVX27", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXWWG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZ2NU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEHHN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWDJL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISMB7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRFLN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRP3K", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6ZXG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIP4ES", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIE2F3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPED2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5YQN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXYR7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8LFH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4XDH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5GNX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXPRD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISZEV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7ZC4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3FH7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5GH9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIN7R8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICXU8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI45W4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEFJE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWMZ2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICDXF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBPUB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7ZTW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWCLX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7UZQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMGH4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBXVZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6VCD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7PBB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHITNMX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIM6D6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI43QD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISWGV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINHAT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3TL6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT62X", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWFTB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI24PN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHVEN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5SXP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPFVF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJVNB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3CAV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIH3BT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIG7GH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDEVG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6QDF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWJF3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7KXC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHPC6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQKAZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXRSA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYF46", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJMGN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRERE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIX7B3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI35TF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGU5R", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9MNG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZSGL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXHPL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIW4CW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT9QA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPXAY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIL9Q7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6TXD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2Z8Y", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4H5Z", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINQES", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2A2K", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2JAK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKXS3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI64BB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2LT9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICTAC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIM9AD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8Y3S", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBRWK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXLMG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7J4G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5LWB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQEFF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPQQG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIY3JY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIV4H3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIH2YS", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6MJ7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6HYB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINJHH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEEK8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVF9C", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMRB6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIW664", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4GNR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDZ8T", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILDJM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVE2N", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBLAU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXGH8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7JSE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI64PD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBXCT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6MRQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDD68", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINLX6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYRSG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDEUP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHW3H", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRLHL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMLBB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJVNP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI58LH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIATFB", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQD8J", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICJFY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINEVH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHITQ4E", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWTGJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7WSG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2W86", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFN9V", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8TTN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISLLM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWVNQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMGSE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILSF6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJT36", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPVZ9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI953M", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHID24M", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPLWP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5XX5", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4RX3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHA6U", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINZL9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJT87", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7BFY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7F9Q", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVAH8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIARWL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIE7JX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6C69", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8XME", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7BU2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZU9W", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGH68", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISC7M", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHEY9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2EGP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPUEV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9P6S", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUR9Z", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3LTR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHITXA8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWFX6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZH3P", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINESD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIU8WW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICMYQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3SLH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4TV8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWVYC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKDVD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWV3B", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIC5CR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4ZSR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPPAJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVLHP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFJRF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4WK6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIW8RE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILGMT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2ZYZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUB4B", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICSEV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIN2C5", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7LG2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4F3P", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKYWR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYZ6M", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIN5EN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9EYZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAZMX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUE6Q", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBRL9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWSG7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6JPH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFGV6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ7KY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFCHF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGYCS", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIACKY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3ZCZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5WVM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHPTY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXE7V", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHEXP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI25ZV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMXDM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHCPY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIN75Z", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIW79E", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3WAJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI68Q8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILMB8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI65RZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIY3ZJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6FW6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI68N2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZQTX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZPUU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJBAY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGVXL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7GQE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ9Z6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDQK8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFR3U", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKQLN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPF3E", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ36C", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIB9KU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZUAZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI44XE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGR89", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI84NV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI74WU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGQCC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI93NT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIA3PC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6YLK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILUEG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDA8W", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIC33K", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEHLX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAJ5K", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIE2R7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWKLW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3GRE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIY69A", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIB92L", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRTEC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ4PN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQTEF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI47FY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3QHM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9FS3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJBQK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWTKG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHITU8L", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3HWS", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJLKY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRWXH", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIV6LV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQ4KZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILXX3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIC3UT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMQ9G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINXBG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICPVA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIMJ6R", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGACR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZ42P", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILR3U", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI9HZ8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUZZ6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5X6L", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINB5N", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKN9G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEBFA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2K8M", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIC34B", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIU475", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIX5EE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXDGC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5ZLZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5PHZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISJ3Y", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQM5Q", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFMSE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6VTS", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJB9W", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2DC7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGGPT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2R4V", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBR24", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWXHE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2WHX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIF8GS", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIE4SJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZUBA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIY6EW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2HU6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFCM8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHYDZ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHDXE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJYKJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVL66", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIW24A", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISS7H", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUCFM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILGGD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWWR5", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2HCC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUNYP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI33WE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAF7T", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8TH3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3ZGG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBYA6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4CYK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6DB9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIWPUU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5DGU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEGCD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIP5JG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3K7W", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHNM2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIK6PP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6Y97", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXHJE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDWV4", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAUZ2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIF7HP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHCDN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGNT8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIE3VF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICZFF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICC3H", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3FX8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFCQX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINJRP", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGV7E", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICBHX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI92CJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIEKXU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINYUU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGWUW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXE2G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHF74", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5A5Y", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQFTX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI3D4S", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFSPA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6TM9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIQHW7", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT5Q6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIH78Z", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHILJ62", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI97EM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIP2ZU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYXL3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDN9A", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8BAC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI69B2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJ9QL", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIK85M", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4BCE", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHICF8F", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHINAMJ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI358H", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAZSC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPGWK", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYMR9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6XQ9", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2MDR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIM4L8", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHISZ9G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIT2MT", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIYURV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIBA4X", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZUCM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5KAU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIRNDG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI7NUM", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIGBXW", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6U5Y", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIUDGY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXH3X", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI88HV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6TBC", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIN89V", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIC7ZN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAWTV", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIPM85", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI2563", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8RTN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVS2G", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIG4HD", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI24H5", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHITDYF", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI8MJR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIXZV3", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIAHAG", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIJBMN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI4H4D", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI57Y6", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIKKY2", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIZ6GR", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIDUJX", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI6WBY", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIVNGU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIG6ZN", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI5W4Q", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIHFLQ", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIX5UA", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHI57PU", 350, 'coupon unused', 0, 1 ],
    # [ "SODELHIFJ3Y", 350, 'coupon unused', 0, 1 ],
  # [ "DJS50", 50, 'coupon unused', 0, 2147483647 ],
  # [ "DJS100", 100, 'coupon unused', 0, 2147483647 ],
  # [ "DJS150", 150, 'coupon unused', 0, 2147483647 ],
  # [ "DJS350", 350, 'coupon unused', 0, 2147483647 ]
  # [ "RBFJ3Y", 350, 'coupon unused', 0, 1 ]

  # [ "SOCIAL100", 100, 'coupon unused', 0, 2147483647 ],
  # [ "REFER100", 100, 'coupon unused', 0, 2147483647 ]

  # ["DJS349", 349, 'coupon unused', 0, 2147483647 ]
  # [ "WEKIFJ3Y", 350, 'coupon unused', 0,  20],
  # [ "WEKIFJ3Y", 350, 'coupon unused', 0,  3],
  # [ "WEKI57PU", 350, 'coupon unused', 0,  1],
  # [ "WEKIX5UA", 350, 'coupon unused', 0,  1],
]

i=0

coupon_list.each do |coupon_code, discount_amount, status, count, max_count|
  Coupon.create( coupon_code: coupon_code, discount_amount: discount_amount, status: status, count: count, max_count: max_count)
  i = i + 1
end

coupon_list2 = [
  # [ "GSBKKY2", 350, 'coupon unused', '2017-09-21', 0, 1 ],
  # [ "GSBZ6GR", 350, 'coupon unused', '2017-09-21', 0, 1 ],
  # [ "GSBDUJX", 350, 'coupon unused', '2017-09-21', 0, 1 ],
  # [ "GSB6WBY", 350, 'coupon unused', '2017-09-21', 0, 1 ],
  # [ "GSBVNGU", 350, 'coupon unused', '2017-09-21', 0, 1 ],
  # [ "GSBG6ZN", 350, 'coupon unused', '2017-09-21', 0, 1 ],
  # [ "GSB5W4Q", 350, 'coupon unused', '2017-09-21', 0, 1 ],
  # [ "GSBHFLQ", 350, 'coupon unused', '2017-09-21', 0, 1 ],
  # [ "GSBX5UA", 350, 'coupon unused', '2017-09-21', 0, 1 ],
  # [ "GSB57PU", 350, 'coupon unused', '2017-09-21', 0, 1 ]
  # [ "SOCIAL150", 150, 'coupon unused', '2017-09-11', 0, 2147483647 ],
  # [ "REFER150", 150, 'coupon unused', '2017-09-11', 0, 2147483647 ]
  # [ "IGMUSKAN", 350, 'coupon unused', '2017-09-21', 0, 1 ]
]

coupon_list2.each do |coupon_code, discount_amount, status, expires_on, count, max_count|
  Coupon.create( coupon_code: coupon_code, discount_amount: discount_amount, status: status, expires_on: expires_on, count: count, max_count: max_count)
  i = i + 1
end

# AdminUser.create!(email: '  mail@akhilsingh.net', password: 'password', password_confirmation: 'password', role: 'admin')
# AdminUser.create!(email: '  jesse@remedicohealth.com', password: 'password', password_confirmation: 'password', role: 'admin')

# doctors_list = [
#   ["sonam@remedico.com", "Sonam", "Vimadalal", "MBBS, DDVL", "Mumbai", "sonam.jpg", "Dr Sonam Vimadalal completed her post-graduate studies in Pune, and has been practising in Mumbai for several years. She is proficient in working with laser and other procedures, and takes a special interest in dermatosurgery and clinical dermatology. She keeps herself abreast of the latest developments in dermatology by attending conferences and continued medical education seminars.</br></br>Dr Vimadalal believes that dermatology issues are never just skin deep but rather a reflection of the internal working system. She takes a holistic approach, with a strong understanding of the impact of endocrinology, nutrition, and lifestyle on skin health. She is a firm believer in understanding the patient's unique needs, and providing in-depth counselling.", true ],
#   ["gaurangi@remedico.com", "Gaurangi", "Shrawat", "MD (Dermatology & VD)", "Pune", "gaurangi.jpg", "Dr Gaurangi Shrawat completed her MD in Pune, where she achieved first class. An experienced clinician, she also practices as a teacher to junior doctors. In addition to her practical work, she is a prominent researcher, having published and presented papers at national conferences.</br></br>Dr Shrawat’s strength lies in her diagnostic ability, and she has a particular interest in clinical dermatology, dermatosurgery, and aesthetics. Having worked with patients across pediatric, adolescent, adult, and geriatric age groups, Dr Shrawat is of the firm belief that healthy skin and hair are strong reflections of a healthy body.", true ],
#   ["ankita@remedico.com", "Ankita", "Sawant", "MBBS, DDV", "Mumbai", "ankita.jpg", "Dr Ankita Sawant completed her post-graduate studies in Mumbai, where she has been practising as a dermatologist and cosmetologist for several years. She takes special interest in clinical dermatology and aesthetics, including botox and fillers. She is also trained in lasers and dermatosurgery.</br></br>Dr Sawant is active within the Indian dermatology community, and has presented several papers in clinical meets and conferences. She excels in her ability to communicate with patients, and provides counseling with special emphasis on the general health of their skin and hair.", true ],
#   ["abhishek@remedico.com", "Abhishek", "Omchery", "MD (Dermatology & VD)", "Delhi", "abhishek.jpg", "Dr Abhishek Omchery completed his MD in Pune, passing with first division. An experienced clinician, he was also formerly an Assistant Professor in the Department of Dermatology at Bharati Hospital, Pune. He is a published researcher, having written several articles on  dermatology for prominent medical journals.</br></br>Dr Omchery has a particular interest in clinical dermatology, hair transplant surgery, dermatosurgery, and aesthetics. He believes it is imperative to inform and educate patients, as well as empathise with the psychological impacts of their skin and hair conditions.", true ],
#   ["gautam@remedico.com", "Gautam", "Dethe", "MBBS, DDV, DNB", "Navi Mumbai", "gautam.jpg", "Dr Gautam Dethe is based in Navi Mumbai, having completed his post-graduate studies in dermatology in Mumbai. Having been practising dermatology for over 15 years, he has held leadership positions including as head of the department of dermatology in Navi Mumbai Municipal Corporation Hospital, where he was responsible for training resident doctors.</br></br>Dr Dethe is highly academically oriented, with his areas of particular interest being acne, hair, and dermatosurgery. He has also done notable work in the field of STDs.", false ],
#   ["pradnya@remedico.com", "Pradnya", "Shastri", "MBBS, DDVL", "Mumbai", "pradnya.jpg", "Dr Shastri initially honed her skills in dermatology at Nanavati Research Center and furthered her experience working as a senior registrar at KEM hospital, Parel. Dr Shastri is a life member of Indian Association of Dermatology, Venerology and Leprology (IADVL) and Cosmetic Dermatologists Society of India (CDSI).</br></br>She has hosted multiple sessions on psychosomatic issues for her patients in collaboration with psychologists. She is passionate about educating people about issues like fairness creams and their side effects, and ensuring that they do not fall prey to false messages about skin and hair on social media. She believes skin care is not just periodic, but an ongoing process that one needs to incorporate into their lifestyle.", false ]
# ]

# doctors_list1 = [
#   ["sonam@remedico.com", "Sonam", "Vimadalal", "MBBS, DDVL", "Mumbai", "sonam.jpg", "Dr Sonam Vimadalal completed her post-graduate studies in Pune, and has been practising in Mumbai for several years. She is proficient in working with laser and other procedures, and takes a special interest in dermatosurgery and clinical dermatology. She keeps herself abreast of the latest developments in dermatology by attending conferences and continued medical education seminars.</br></br>Dr Vimadalal believes that dermatology issues are never just skin deep but rather a reflection of the internal working system. She takes a holistic approach, with a strong understanding of the impact of endocrinology, nutrition, and lifestyle on skin health. She is a firm believer in understanding the patient's unique needs, and providing in-depth counselling.", true, 101, 5 ],
#   ["gaurangi@remedico.com", "Gaurangi", "Shrawat", "MD (Dermatology & VD)", "Pune", "gaurangi.jpg", "Dr Gaurangi Shrawat completed her MD in Pune, where she achieved first class. An experienced clinician, she also practices as a teacher to junior doctors. In addition to her practical work, she is a prominent researcher, having published and presented papers at national conferences.</br></br>Dr Shrawat’s strength lies in her diagnostic ability, and she has a particular interest in clinical dermatology, dermatosurgery, and aesthetics. Having worked with patients across pediatric, adolescent, adult, and geriatric age groups, Dr Shrawat is of the firm belief that healthy skin and hair are strong reflections of a healthy body.", true, 101, 5  ],
#   ["ankita@remedico.com", "Ankita", "Sawant", "MBBS, DDV", "Mumbai", "ankita.jpg", "Dr Ankita Sawant completed her post-graduate studies in Mumbai, where she has been practising as a dermatologist and cosmetologist for several years. She takes special interest in clinical dermatology and aesthetics, including botox and fillers. She is also trained in lasers and dermatosurgery.</br></br>Dr Sawant is active within the Indian dermatology community, and has presented several papers in clinical meets and conferences. She excels in her ability to communicate with patients, and provides counseling with special emphasis on the general health of their skin and hair.", true, 101, 5 ],
#   ["abhishek@remedico.com", "Abhishek", "Omchery", "MD (Dermatology & VD)", "Delhi", "abhishek.jpg", "Dr Abhishek Omchery completed his MD in Pune, passing with first division. An experienced clinician, he was also formerly an Assistant Professor in the Department of Dermatology at Bharati Hospital, Pune. He is a published researcher, having written several articles on  dermatology for prominent medical journals.</br></br>Dr Omchery has a particular interest in clinical dermatology, hair transplant surgery, dermatosurgery, and aesthetics. He believes it is imperative to inform and educate patients, as well as empathise with the psychological impacts of their skin and hair conditions.", true, 50, 7  ]
# ]

# doctors_list1.each do |email, first_name, last_name, qualification, location, avatar, desc, available_for_consultation, consultations_count, experience|
#   Doctor.create(email: email, password: 'password', password_confirmation: 'password', first_name: first_name, last_name: last_name, qualification: qualification, location: location, avatar: avatar, desc: desc, available_for_consultation: available_for_consultation, experience: experience, consultations_count: consultations_count)
#   i += 1
# end

# doctors_list2 = [
#   ["gautam@remedico.com", "Gautam", "Dethe", "MBBS, DDV, DNB", "Navi Mumbai", "gautam.jpg", "Dr Gautam Dethe is based in Navi Mumbai, having completed his post-graduate studies in dermatology in Mumbai. Having been practising dermatology for over 15 years, he has held leadership positions including as head of the department of dermatology in Navi Mumbai Municipal Corporation Hospital, where he was responsible for training resident doctors.</br></br>Dr Dethe is highly academically oriented, with his areas of particular interest being acne, hair, and dermatosurgery. He has also done notable work in the field of STDs.", false ],
#   ["pradnya@remedico.com", "Pradnya", "Shastri", "MBBS, DDVL", "Mumbai", "pradnya.jpg", "Dr Shastri initially honed her skills in dermatology at Nanavati Research Center and furthered her experience working as a senior registrar at KEM hospital, Parel. Dr Shastri is a life member of Indian Association of Dermatology, Venerology and Leprology (IADVL) and Cosmetic Dermatologists Society of India (CDSI).</br></br>She has hosted multiple sessions on psychosomatic issues for her patients in collaboration with psychologists. She is passionate about educating people about issues like fairness creams and their side effects, and ensuring that they do not fall prey to false messages about skin and hair on social media. She believes skin care is not just periodic, but an ongoing process that one needs to incorporate into their lifestyle.", false ]
# ]

# doctors_list2.each do |email, first_name, last_name, qualification, location, avatar, desc, available_for_consultation|
#   Doctor.create(email: email, password: 'password', password_confirmation: 'password', first_name: first_name, last_name: last_name, qualification: qualification, location: location, avatar: avatar, desc: desc, available_for_consultation: available_for_consultation)
#   i += 1
# end

# Doctor.find_by(:email => "sonam@remedico.com").update({:code => 'svim', :email => 'sonam_v7@yahoo.com', :available_for_selfie_checkup => true})
# Doctor.find_by(:email => "gaurangi@remedico.com").update({:code => 'grg', :email => 'gaurangishrawat@yahoo.com', :available_for_selfie_checkup => true})
# Doctor.find_by(:email => "ankita@remedico.com").update({:code => 'asaw', :email => 'ankita.sawant1@gmail.com', :available_for_selfie_checkup => true})
# Doctor.find_by(:email => "abhishek@remedico.com").update({:code => 'aom', :email => 'abhishekomchery@gmail.com'})
# Doctor.find_by(:email => "gautam@remedico.com").update({:code => 'gdet'})
# Doctor.find_by(:email => "pradnya@remedico.com").update({:code => 'prd'})

# conditions_list = [
# [ "tanning", "tanning", "<b><i>tanning</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Indian skin types tend to tan and not burn. This is due to the level of melanin (pigment produced by colour-producing cells) in their skin. The amount of tan depends on the light and exposure. After exposure some people experience immediate darkening - this is due to UVA rays. A delayed tanning can be seen with UVB rays which increases the number and activity of melanin cells. This also increases with multiple exposures. Thus photopretection is important. This delayed tan can stay for many weeks. Using adequate sunscreen and other photoprotective measures can reduce the tanning effect.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> It can take weeks to rid off a tan. Certain medicated creams along with photoprotection can help you get rid of it faster.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> If you're in a habit of constantly rubbing your forehead with your hand or a handkerchief then that can also cause this type of pigmentation over time.</div>" ],
# [ "acne1", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 1 acne</b>.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne2", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 2 acne</b>.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne3", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 3 acne</b>.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne4", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 4 acne</b>.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne12", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 1-2 acne</b>.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne23", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 2-3 acne</b>.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "pih", "post-inflammatory hyperpigmentation", "<b><i>post-inflammatory hyperpigmentation</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Post-inflammatory hyper-pigmentation is the discolouration left behind on your skin after an inflammation (usually acne) subsides. Acne as a condition has a tendency to leave marks/dark spots as it heals. It can take anywhere from 2 weeks to a few months to recede, depending on the grade of acne you had, and how you handle your skin.</div>" ],
# [ "dark circles", "dark circles", "<b><i>peri-orbital hyperpigmentation</i></b>, or dark circles", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Dark circles can have many causes, and thus it becomes difficult to obtain a complete remedy and satisfactory treatment. The most common reason is deep set eyeballs into the orbit which causes shadowing and gives an appearance of dark circles. Family history of dark circles point to a genetic cause. These are very difficult to treat and no applications can help more than a certain limit. </div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Besides these, vitamin B12 deficiency, lack of sleep for a prolonged period, wrinkles due to age or dryness, excessive rubbing of eyes due to habit or dry eyes or overuse of gadgets, excessive kohl usage and especially not washing it off before sleeping can also contribute. Sometimes the skin of the undereyes area is so thin that the veins running under it give a dark hue to the skin, giving the appearance of dark circles.</div>" ],
# [ "acanthosis nigricans", "acanthosis nigricans", "<b><i>acanthosis nigricans</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Acanthosis nigricans is a condition in which there is darkening and thickening of skin folds e.g. neck, underarms and groin. There is also darkening of the skin around the eyes, mouth, elbows, knees and knuckles. It is a skin manifestation of an underlying internal disorder, the most common being insulin resistance.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> In this condition, the excess insulin circulating in the body can give rise to sweet cravings, weight gain, difficulty in losing weight, lethargy, acne and hair thinning along with the pigmentation. It is also seen in thyroid disorders and may also be caused by certain drugs like oral contraceptive pills and oral steroids.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Weight loss remains the treatment of choice. Applications containing skin exfoliants will help.</div>" ],
# [ "PDL", "pigmentary demarcation lines", "<b><i>pigmentary demarcation lines</i></b> (PDL)", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> PDL refers to areas of darker skin colour at places with abrupt transition to normal skin colour. They have sharply defined borders. The cause is unknown but there is a racial and genetic predisposition with Indians mostly having them on the face. These demarcation lines may also be present on the trunk and limbs in predisposed individuals. On the face they may appear in a 'V' or 'W' pattern which is bilaterally symmetrical extending from the undereye area to the sides of forehead and upper cheeks.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> They may be present during childhood and go unnoticed, and may become apparent later in life with triggering factors such as puberty or pregnancy. Even certain acute illnesses like viral infections may trigger this.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> This pigmentation is dermal (in the deeper layer of skin) and therefore persistent. No treatment is satisfactory. Sun exposure worsens the appearance.</div>" ],
# [ "post-acne scarring", "post-acne scarring", "<b><i>post-acne scarring</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Post-acne scarring occurs in certain individuals who have a tendency to scar. As the skin heals after acne, scars or pits are left on the skin. The more severe the acne, the worse the scarring that can occur.</div>" ],
# [ "photomelanosis", "photomelanosis", "<b><i>photomelanosis</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Years of sun exposure without adequate protection leads to slow progressive damage to the skin and is seen as brown spots on the skin (photomelanosis). The right skin care products with a good diet and exercise regimen, supplemented with oral vitamins is the mainstay to treat and prevent further pigmentation.</div>" ],
# [ "milia", "milia", "<b><i>milia</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Milia are small white bumps seen on the skin usually on the face on the cheeks and around the eyes. They are a collection of oil and protein called keratin. These materials get collected together and form a tiny cyst-like structure called milia. These can also be formed from trauma like excessive rubbing of the skin. They are harmless.</div>" ],
# [ "photodamage", "photodamage", "<b><i>photodamage</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Years of sun exposure without adequate protection leads to slow progressive damage to the skin and is seen as brown spots on the skin (photodamage). The right skin care products with a good diet and exercise regimen, supplemented with oral vitamins is the mainstay to treat and prevent further pigmentation. </div>" ],
# [ "lip pigmentation", "lip pigmentation", "<b><i>pigmentation on your lip</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Dark lips are a common occurrence amongst Indians. Most of us have constitutionally dark lips, but there are other causes of lip darkening as well.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Smoking incessantly causes excess heat accumulation in the delicate lip mucosal area, and gives a grey tinge to them making them appear dark. Lip biting and licking is a habit some people tend to have, whcih can also damage the lip mucosal and cause darkening of the lips as they heal.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> Any cosmetics (especially expired cosmetics or overuse of lipsticks) which don't suit the skin of the lips may cause a reaction and that too can lead to pigmentation. Drinking enough water hydrates the skin and the lips and prevents lips from looking wrinkled and dark.</div>" ],
# [ "lentigines", "lentigines", "<b><i>lentigines</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> These are small brown spots on the skin that occur due to an increase in the number of pigment cells. They can be slightly raised, or flat on the skin or the mucous membranes. They usually start off in childhood, and increase in number until adult life. They then may stop or fade away. In general they are not dependant on the amount of sun exposure (unless the lentigenes are of the solar variety), nor do they vary with the seasons.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> These are benign lesions, and treating them aggressively by removal may lead to scarring. If a very large number are present then a detailed systemic examination must be done.</div>" ],
# [ "dpn", "dermatosis papulosa nigra", "<b><i>dermatosis papulosa nigra </i></b> (DPN)", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> DPNs or dermatosis papulosa nigra are tiny, raised, but completely harmless growths on the skin that may occur during adolescence. They are usually seen in dark skinned individuals. The cause is usually unknown but there may be a genetic preponderance and it seen more in females. They may increase in size and number once formed.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> They do not pose any health risk. There is no treatment for them once they have occurred but using a good sunscreen may prevent new ones to a degree. Treatment is not mandatory.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> If they are cosmetically unappealing, then removal is the treatment of choice. Removal can be done by electrocautery or radiofrequency cauterisation. However it should be noted that newer ones may appear after the procedure.</div>" ],
# [ "folliculitis", "folliculitis", "<b><i>folliculitis</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>You have folliculitis, which is the inflammation of hair follicles. Usually it is a secondary effect of trauma, such as shaving, waxing, tweezing, oil massages or wearing tight clothes that rub against the skin thus irritating the follicles. They can also become blocked or irritated by sweat, oils, or make up. Such injured follicles are more likely to become infected especially with bacteria, and sometimes with fungus.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'> It presents as small red bumps on the traumatized area with a hair coming out of its centre, with or without pus. It can occur on any part of your body that has hair but is most common on the beard area, arms, back, buttocks, and legs.</div>" ],
# [ "aa1 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade I. </div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa2 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade II. </div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa3 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade III. </div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa4 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade IV. </div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa5 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade V. </div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa female", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>You have androgenetic alopecia, also known as female patterned baldness. This condition presents in certain genetically prone individuals, who have a sensitivity to androgens (male hormones), which causes thinning of the hair from the front side. Often this increases after menopause.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Over a period of time the thinning can extend to the midline of the scalp, and this is seen as a widening of the hair partition. The hair in the front also starts changing, and begins to look like thin wisps of baby hair. However, females never go completely bald. The hairline is always maintained in spite of the front and midline thinning. </div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>The hair fall associated with this can be due to stress, nutritional deficiencies (such as vitamin and protein), travel, change of temperatures, water quality, and dandruff.</div>" ],
# [ "atrophic scars", "atrophic scars", "<b><i>atrophic scars</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Atrophic scars appear as pits or depressions of varying depths on the skin . They result due to destruction of collagen following an inflammatory condition (commonly acne, chicken pox). The degree of scarring depends of degree of inflammation, and the patient's genetic susceptibility.</div>" ],
# [ "nevi", "compound nevi", "<b><i>compound nevi</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Nevi are more commonly known as birthmarks or moles, though they usually do not appear at birth. They may appear in childhood or post puberty, and can increase in size and number in one's 20s and 30s. Compound nevi are the raised and pigmented ones, and sometimes have hair coming out of them.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>They are harmless and usually only pose a cosmetic problem. If at any time they enlarge rapidly in size or numbers, or the border and surface changes from a smooth, round, edge to ragged, uneven, edges then you should get them examined. Bleeding or pain from a nevus also shouldn't be ignored.</div>" ],
# [ "Peri-oral hyperpigmentation", "peri-oral hyperpigmentation", "<b><i>peri-oral hyperpigmentation</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>This is shadowing or pigmentation seen around the lips and sides of the mouth, sometimes extending up to the chin. It can occur after a perioral dermatitis, which may heal with a bit of darkening of the involved skin. It can also be caused due to an allergic reaction to a variety of things like spicy or tangy foods, flouride toothpastes, or cosmetics. Dribbling of saliva due to braces, open mouthed breathing due to nasal issues, and licking your lips can also cause this dermatitis. Friction or rubbing of the area constantly can also produce this pigmentation. A multivitamin and folic acid deficiency should also be ruled out with this type of pigmentation.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Another important cause of this type of pigmentation is Insulin resistance which gives rise to a condition known as acanthosis nigricans. (This may be a part of poly cystic syndrome in women). In this condition, the excess insulin circulating in the body can give rise to sweet cravings, weight gain, difficulty in losing weight, lethargy, acne and hair thinning and also darkening of the skin around the eyes, mouth, neck, underarms and groin. If this is the case, it is possible that your diet may need cleaning up, and if you are having sugar cravings and excess sugar in your diet, that needs to be reduced to clear the pigmentation. </div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>In this case, along with the treatment by applications, a good lifestyle with adequate exercise is necessary. Weight loss by improving the diet is the key for getting rid of this type of pigmentation. Reducing sugar and processed and oily foods, including fruits, vegetables, nuts and proteins in the diet will help. Any form of cardiovascular exercise to improve the metabolism of the body will help.</div>" ],
# [ "frictional hyperpigmentation", "frictional hyperpigmentation", "<b><i>frictional hyperpigmentation</i></b>", "<div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>Friction or trauma by rubbing a particular body part can lead to an irritation of the skin, which results in pigmentation and a darker hue of the rubbed area. Stopping the friction can result in improvement of the pigmentation as soon as in 2 weeks.</div> <div style='font-family:Arial, Helvetica, sans-serif;font-size:16px;color:#515151 ;line-height:20px;margin-bottom:15px'>The most commonly involved area is the forehead, where one may rub it constantly to wipe the sweat off the brow, post exercise, or even while experiencing a headache. Dark circles also get worse with rubbing.</div>" ]
# ]


# conditions_list.each do |key, title, inline_desc, desc|
#   Condition.create( key: key, title: title, inline_desc: inline_desc, desc: desc)
#   i += 1
# end

# conditions_list = [
# [ "tanning", "tanning", "<b><i>tanning</i></b>", "<div style='margin-bottom:15px'> Indian skin types tend to tan and not burn. This is due to the level of melanin (pigment produced by colour-producing cells) in their skin. The amount of tan depends on the light and exposure. After exposure some people experience immediate darkening - this is due to UVA rays. A delayed tanning can be seen with UVB rays which increases the number and activity of melanin cells. This also increases with multiple exposures. Thus photopretection is important. This delayed tan can stay for many weeks. Using adequate sunscreen and other photoprotective measures can reduce the tanning effect.</div> <div style='margin-bottom:15px'> It can take weeks to rid off a tan. Certain medicated creams along with photoprotection can help you get rid of it faster.</div> <div style='margin-bottom:15px'> If you're in a habit of constantly rubbing your forehead with your hand or a handkerchief then that can also cause this type of pigmentation over time.</div>" ],
# [ "acne1", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 1 acne</b>.</div> <div style='margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne2", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 2 acne</b>.</div> <div style='margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne3", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 3 acne</b>.</div> <div style='margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne4", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 4 acne</b>.</div> <div style='margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne12", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 1-2 acne</b>.</div> <div style='margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "acne23", "acne", "<b><i>acne vulgaris</i></b>, commonly known as acne", "<div style='margin-bottom:15px'> Acne vulgaris (or simply acne) is a condition caused by oil and dead skin clogging up hair follicles (pores) on the skin. There are four grades of acne, ranging from white / black heads (grade 1), to hard and painful pus-filled cysts (grade 4). It looks like you may have <b>grade 2-3 acne</b>.</div> <div style='margin-bottom:15px'> Acne is caused by an increase in oil gland activity especially during adolescent and young adult years, and is often triggered by: incorrect hygiene (especially not washing the face regularly and thoroughly), improper diet and/or lifestyle (especially excessive junk food, and insufficient exercise), and stress.</div>" ],
# [ "pih", "post-inflammatory hyperpigmentation", "<b><i>post-inflammatory hyperpigmentation</i></b>", "<div style='margin-bottom:15px'> Post-inflammatory hyper-pigmentation is the discolouration left behind on your skin after an inflammation (usually acne) subsides. Acne as a condition has a tendency to leave marks/dark spots as it heals. It can take anywhere from 2 weeks to a few months to recede, depending on the grade of acne you had, and how you handle your skin.</div>" ],
# [ "dark circles", "dark circles", "<b><i>peri-orbital hyperpigmentation</i></b>, or dark circles", "<div style='margin-bottom:15px'> Dark circles can have many causes, and thus it becomes difficult to obtain a complete remedy and satisfactory treatment. The most common reason is deep set eyeballs into the orbit which causes shadowing and gives an appearance of dark circles. Family history of dark circles point to a genetic cause. These are very difficult to treat and no applications can help more than a certain limit. </div> <div style='margin-bottom:15px'> Besides these, vitamin B12 deficiency, lack of sleep for a prolonged period, wrinkles due to age or dryness, excessive rubbing of eyes due to habit or dry eyes or overuse of gadgets, excessive kohl usage and especially not washing it off before sleeping can also contribute. Sometimes the skin of the undereyes area is so thin that the veins running under it give a dark hue to the skin, giving the appearance of dark circles.</div>" ],
# [ "acanthosis nigricans", "acanthosis nigricans", "<b><i>acanthosis nigricans</i></b>", "<div style='margin-bottom:15px'> Acanthosis nigricans is a condition in which there is darkening and thickening of skin folds e.g. neck, underarms and groin. There is also darkening of the skin around the eyes, mouth, elbows, knees and knuckles. It is a skin manifestation of an underlying internal disorder, the most common being insulin resistance.</div> <div style='margin-bottom:15px'> In this condition, the excess insulin circulating in the body can give rise to sweet cravings, weight gain, difficulty in losing weight, lethargy, acne and hair thinning along with the pigmentation. It is also seen in thyroid disorders and may also be caused by certain drugs like oral contraceptive pills and oral steroids.</div> <div style='margin-bottom:15px'> Weight loss remains the treatment of choice. Applications containing skin exfoliants will help.</div>" ],
# [ "PDL", "pigmentary demarcation lines", "<b><i>pigmentary demarcation lines</i></b> (PDL)", "<div style='margin-bottom:15px'> PDL refers to areas of darker skin colour at places with abrupt transition to normal skin colour. They have sharply defined borders. The cause is unknown but there is a racial and genetic predisposition with Indians mostly having them on the face. These demarcation lines may also be present on the trunk and limbs in predisposed individuals. On the face they may appear in a 'V' or 'W' pattern which is bilaterally symmetrical extending from the undereye area to the sides of forehead and upper cheeks.</div> <div style='margin-bottom:15px'> They may be present during childhood and go unnoticed, and may become apparent later in life with triggering factors such as puberty or pregnancy. Even certain acute illnesses like viral infections may trigger this.</div> <div style='margin-bottom:15px'> This pigmentation is dermal (in the deeper layer of skin) and therefore persistent. No treatment is satisfactory. Sun exposure worsens the appearance.</div>" ],
# [ "post-acne scarring", "post-acne scarring", "<b><i>post-acne scarring</i></b>", "<div style='margin-bottom:15px'> Post-acne scarring occurs in certain individuals who have a tendency to scar. As the skin heals after acne, scars or pits are left on the skin. The more severe the acne, the worse the scarring that can occur.</div>" ],
# [ "photomelanosis", "photomelanosis", "<b><i>photomelanosis</i></b>", "<div style='margin-bottom:15px'> Years of sun exposure without adequate protection leads to slow progressive damage to the skin and is seen as brown spots on the skin (photomelanosis). The right skin care products with a good diet and exercise regimen, supplemented with oral vitamins is the mainstay to treat and prevent further pigmentation.</div>" ],
# [ "milia", "milia", "<b><i>milia</i></b>", "<div style='margin-bottom:15px'> Milia are small white bumps seen on the skin usually on the face on the cheeks and around the eyes. They are a collection of oil and protein called keratin. These materials get collected together and form a tiny cyst-like structure called milia. These can also be formed from trauma like excessive rubbing of the skin. They are harmless.</div>" ],
# [ "photodamage", "photodamage", "<b><i>photodamage</i></b>", "<div style='margin-bottom:15px'> Years of sun exposure without adequate protection leads to slow progressive damage to the skin and is seen as brown spots on the skin (photodamage). The right skin care products with a good diet and exercise regimen, supplemented with oral vitamins is the mainstay to treat and prevent further pigmentation. </div>" ],
# [ "lip pigmentation", "lip pigmentation", "<b><i>pigmentation on your lip</i></b>", "<div style='margin-bottom:15px'> Dark lips are a common occurrence amongst Indians. Most of us have constitutionally dark lips, but there are other causes of lip darkening as well.</div> <div style='margin-bottom:15px'> Smoking incessantly causes excess heat accumulation in the delicate lip mucosal area, and gives a grey tinge to them making them appear dark. Lip biting and licking is a habit some people tend to have, whcih can also damage the lip mucosal and cause darkening of the lips as they heal.</div> <div style='margin-bottom:15px'> Any cosmetics (especially expired cosmetics or overuse of lipsticks) which don't suit the skin of the lips may cause a reaction and that too can lead to pigmentation. Drinking enough water hydrates the skin and the lips and prevents lips from looking wrinkled and dark.</div>" ],
# [ "lentigines", "lentigines", "<b><i>lentigines</i></b>", "<div style='margin-bottom:15px'> These are small brown spots on the skin that occur due to an increase in the number of pigment cells. They can be slightly raised, or flat on the skin or the mucous membranes. They usually start off in childhood, and increase in number until adult life. They then may stop or fade away. In general they are not dependant on the amount of sun exposure (unless the lentigenes are of the solar variety), nor do they vary with the seasons.</div> <div style='margin-bottom:15px'> These are benign lesions, and treating them aggressively by removal may lead to scarring. If a very large number are present then a detailed systemic examination must be done.</div>" ],
# [ "dpn", "dermatosis papulosa nigra", "<b><i>dermatosis papulosa nigra </i></b> (DPN)", "<div style='margin-bottom:15px'> DPNs or dermatosis papulosa nigra are tiny, raised, but completely harmless growths on the skin that may occur during adolescence. They are usually seen in dark skinned individuals. The cause is usually unknown but there may be a genetic preponderance and it seen more in females. They may increase in size and number once formed.</div> <div style='margin-bottom:15px'> They do not pose any health risk. There is no treatment for them once they have occurred but using a good sunscreen may prevent new ones to a degree. Treatment is not mandatory.</div> <div style='margin-bottom:15px'> If they are cosmetically unappealing, then removal is the treatment of choice. Removal can be done by electrocautery or radiofrequency cauterisation. However it should be noted that newer ones may appear after the procedure.</div>" ],
# [ "folliculitis", "folliculitis", "<b><i>folliculitis</i></b>", "<div style='margin-bottom:15px'>You have folliculitis, which is the inflammation of hair follicles. Usually it is a secondary effect of trauma, such as shaving, waxing, tweezing, oil massages or wearing tight clothes that rub against the skin thus irritating the follicles. They can also become blocked or irritated by sweat, oils, or make up. Such injured follicles are more likely to become infected especially with bacteria, and sometimes with fungus.</div> <div style='margin-bottom:15px'> It presents as small red bumps on the traumatized area with a hair coming out of its centre, with or without pus. It can occur on any part of your body that has hair but is most common on the beard area, arms, back, buttocks, and legs.</div>" ],
# [ "aa1 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade I. </div> <div style='margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa2 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade II. </div> <div style='margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa3 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade III. </div> <div style='margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa4 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade IV. </div> <div style='margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa5 male", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='margin-bottom:15px'>You have been diagnosed with genetic male-pattern hair thinning / balding (androgenetic alopecia). Hair thinning has 7 grades, starting with receding hair line / thinning (grade I) and going all the way to complete baldness (grade VII). You are currently experiencing grade V. </div> <div style='margin-bottom:15px'>Male-pattern baldness is an inherited condition, and is caused by either an increase in DHT (dihydrotestosterone) hormone levels, or a genetically-determined sensitivity to DHT. It can be seen as soon as in a person's early 20s. It can be aggravated by stress, vitamin / nutritional deficiencies, and dandruff / scalp inflammation. Travel can also cause hair shedding due to the change in weather or water.</div>" ],
# [ "aa female", "androgenetic alopecia", "<b><i>androgenetic alopecia</i></b>", "<div style='margin-bottom:15px'>You have androgenetic alopecia, also known as female patterned baldness. This condition presents in certain genetically prone individuals, who have a sensitivity to androgens (male hormones), which causes thinning of the hair from the front side. Often this increases after menopause.</div> <div style='margin-bottom:15px'>Over a period of time the thinning can extend to the midline of the scalp, and this is seen as a widening of the hair partition. The hair in the front also starts changing, and begins to look like thin wisps of baby hair. However, females never go completely bald. The hairline is always maintained in spite of the front and midline thinning. </div> <div style='margin-bottom:15px'>The hair fall associated with this can be due to stress, nutritional deficiencies (such as vitamin and protein), travel, change of temperatures, water quality, and dandruff.</div>" ],
# [ "atrophic scars", "atrophic scars", "<b><i>atrophic scars</i></b>", "<div style='margin-bottom:15px'>Atrophic scars appear as pits or depressions of varying depths on the skin . They result due to destruction of collagen following an inflammatory condition (commonly acne, chicken pox). The degree of scarring depends of degree of inflammation, and the patient's genetic susceptibility.</div>" ],
# [ "nevi", "compound nevi", "<b><i>compound nevi</i></b>", "<div style='margin-bottom:15px'>Nevi are more commonly known as birthmarks or moles, though they usually do not appear at birth. They may appear in childhood or post puberty, and can increase in size and number in one's 20s and 30s. Compound nevi are the raised and pigmented ones, and sometimes have hair coming out of them.</div> <div style='margin-bottom:15px'>They are harmless and usually only pose a cosmetic problem. If at any time they enlarge rapidly in size or numbers, or the border and surface changes from a smooth, round, edge to ragged, uneven, edges then you should get them examined. Bleeding or pain from a nevus also shouldn't be ignored.</div>" ],
# [ "Peri-oral hyperpigmentation", "peri-oral hyperpigmentation", "<b><i>peri-oral hyperpigmentation</i></b>", "<div style='margin-bottom:15px'>This is shadowing or pigmentation seen around the lips and sides of the mouth, sometimes extending up to the chin. It can occur after a perioral dermatitis, which may heal with a bit of darkening of the involved skin. It can also be caused due to an allergic reaction to a variety of things like spicy or tangy foods, flouride toothpastes, or cosmetics. Dribbling of saliva due to braces, open mouthed breathing due to nasal issues, and licking your lips can also cause this dermatitis. Friction or rubbing of the area constantly can also produce this pigmentation. A multivitamin and folic acid deficiency should also be ruled out with this type of pigmentation.</div> <div style='margin-bottom:15px'>Another important cause of this type of pigmentation is Insulin resistance which gives rise to a condition known as acanthosis nigricans. (This may be a part of poly cystic syndrome in women). In this condition, the excess insulin circulating in the body can give rise to sweet cravings, weight gain, difficulty in losing weight, lethargy, acne and hair thinning and also darkening of the skin around the eyes, mouth, neck, underarms and groin. If this is the case, it is possible that your diet may need cleaning up, and if you are having sugar cravings and excess sugar in your diet, that needs to be reduced to clear the pigmentation. </div> <div style='margin-bottom:15px'>In this case, along with the treatment by applications, a good lifestyle with adequate exercise is necessary. Weight loss by improving the diet is the key for getting rid of this type of pigmentation. Reducing sugar and processed and oily foods, including fruits, vegetables, nuts and proteins in the diet will help. Any form of cardiovascular exercise to improve the metabolism of the body will help.</div>" ],
# [ "frictional hyperpigmentation", "frictional hyperpigmentation", "<b><i>frictional hyperpigmentation</i></b>", "<div style='margin-bottom:15px'>Friction or trauma by rubbing a particular body part can lead to an irritation of the skin, which results in pigmentation and a darker hue of the rubbed area. Stopping the friction can result in improvement of the pigmentation as soon as in 2 weeks.</div> <div style='margin-bottom:15px'>The most commonly involved area is the forehead, where one may rub it constantly to wipe the sweat off the brow, post exercise, or even while experiencing a headache. Dark circles also get worse with rubbing.</div>" ]
# ]


# conditions_list.each do |key, title, inline_desc, desc|
#   Condition.find_by(:key => key, :title => title).update({:desc => desc})
#   i += 1
# end

# doctors_list = [
#   ["askdrasmita@gmail.com", "Asmita", "Dhekne Chebbi", "Dermatologist - MD (Dermatology & VD)", "Bangalore", "asmita.jpg", "Dr Asmita Dhekne Chebbi is a Bangalore-based dermatologist. She completed her post-graduation in dermatology in Belgaum. Having worked with some of the best cosmetologists in Bangalore, Dr Chebbi has gained deep expertise in treating acne, pigmentation, skin rejuvenation, scar reduction, among others, in the field of clinical and aesthetic dermatology.</br></br>Her consistently high ratings from patients are due to her meticulous diagnosis and prescriptions. A member of Indian Association of Dermatology, Venerology and Leprology (IADVL), Dr Chebbi subscribes to the belief that ‘every skin type is unique and beautiful – one just has to know the right way to take care of it’. A movie buff and a cricket enthusiast, Dr Chebbi loves to indulge in occasional cheat meals with her family, as she believes life needs to have balance!", false, 'asmitasonam_v7@yahoo.com' ],
#   ["drsanabhamla@gmail.com", "Sana", "Bhamla Khan", "Dermatologist - MBBS, DDV", "Mumbai", "sana.jpg", "Dr Sana Bhamla Khan is a practising dermatologist in Mumbai, having passed out as a University topper among all other Dermatologists.</br></br>Her expertise encompasses dermatology, trichology, paediatric dermatology, cosmetology and aesthetics. Her research work on the Diagnosis of Hair fall was published in the International Journal of Trichology, and won an international award at the European Hair Research Society Meet. She has also received special training for vitiligo surgeries.</br></br>She is an active member of Cosmetic Dermatology Society of India (CDSI), Indian Association of Dermatologists, Venereologists & Leprologists (IADVL), and the Hair Research Society of India.</br></br>She is known for giving her utmost best to every patient who seeks her help.", false, 'sana' ]
# ]

# doctors_list.each do |email, first_name, last_name, qualification, location, avatar, desc, available_for_consultation, code|
#   Doctor.create(email: email, password: 'password', password_confirmation: 'password', first_name: first_name, last_name: last_name, qualification: qualification, location: location, avatar: avatar, desc: desc, available_for_consultation: available_for_consultation, code: code)
#   i += 1
# end

# # SimpleQuiz - skin type quiz questionnaire
# SimpleQuiz.create({
#   :content_type => "skin type quiz",
#   :questions => [
#     {
#       :id => 1,
#       :question => "How does your skin look like at the end of the day?",
#       :options => ["Shiny", "Dull and dry", "My central T zone is shiny, and the rest is dry", "Reddish and rashy", "None of the above"]
#     },
#     {
#       :id => 2,
#       :question => "If you touch your face first thing in the morning before washing, how does it feel?",
#       :options => ["Slimy or oily ", "Dry", "Slimy or oil at some areas, dry at other areas", "Sore or rashy", "None of the above"]
#     },
#     {
#       :id => 3,
#       :question => "What would you say is your major skin issue?",
#       :options => ["Acne / pimples ", "Stretchy and dull skin", "Acne / pimples on forehead and nose, but cheeks are dry and dull", "Redness", "None of the above"]
#     },
#     {
#       :id => 4,
#       :question => "How does it feel after you've washed your face with your face wash?",
#       :options => ["Still not clean", "Tight and stretched", "Clean and bright at some areas, tight and stretched at other areas", "Itchy and rashy", "Clean and bright"]
#     },
#     {
#       :id => 5,
#       :question => "Do you feel the need to use a moisturiser during the day?",
#       :options => ["Never, my skin already feels oily", "Always", "Sometimes yes, sometimes no", "Yes, but I need to be careful, as all creams don't suit my skin", "None of the above"]
#     }
#   ]
# })

# # Default diagnosis for SimpleQuiz - skin type quiz
# Diagnosis.create([
#   {
#     :category => "skin type quiz",
#     :sub_category => "oily sensitive",
#     :content => {
#       :title =>  "oily sensitive skin",
#       :sub_title => "It seems like you have <b>oily sensitive skin</b>. ",
#       :paras => [
#         {
#           :content => "Since your skin is <b>oily</b>, you may find that you have enlarged pores and blackheads, pimples and blemishes on your face. Your complexion may be shiny because of the excess oil produced. Besides this, weather, puberty, hormones, and even stress can also cause or contribute to oily skin. ",
#           :things_you_can_do => {
#             :title => "Some things you can do: ",
#             :content => [
#               "<b>Wash your skin regularly</b> - once or twice a day at least,  and more if you are working out / sweating a lot. ",
#               "<b>Use a gentle cleanser / face wash</b> whenever you wash, and do not scrub your face! ",
#               "If you get pimples, <b>do not pop or pick at them</b> - not only does this spread infection, it can leave scars which are very stubborn. ",
#               "Use skin care and cosmetic products that <b>do not clog pores</b> - they are usually labeled as <b>non-comedogenic</b>. "
#             ]
#           }
#         },
#         {
#           :content => "Since your skin is also <b>sensitive</b>, you may have dry areas on your skin, redness and sometimes even itching and burning. ",
#           :things_you_can_do => {
#             :title => "Some things you can do: ",
#             :content => [
#               "Usually, there is a <b>trigger</b> to this type of skin, and if you do find out what that is, avoid it as soon as possible. The most common trigger is <b>skin care products and makeup</b>, so read your labels carefully! Always watch what you put on your face - whether it is makeup, face washes or even lotions. Read labels to make sure the product is made for sensitive skin - that is key when it comes to your skin type.",
#               "The sun is also a major trigger, so <b>always wear sunscreen</b> even if you're only going out for a short while. UV rays can destroy the texture of your skin and sun burns are just not fun."
#             ]
#           }
#         }
#       ]
#     }
#   },
#   {
#     :category => "skin type quiz",
#     :sub_category => "dry sensitive",
#     :content => {
#       :title =>  "dry sensitive skin",
#       :sub_title => "It seems like you have <b>dry sensitive skin</b>. ",
#       :paras => [
#         {
#           :content => "Since your skin is <b>dry</b>, your pores are small, and your skin may have visible lines. You may also have red patches and reduced elasticity in your skin, causing a dull complexion. Dry skin is easily irritated and so it can crack, itch or get inflamed easily. ",
#           :things_you_can_do => {
#             :title => "Some things you can do for this: ",
#             :content => [
#               "<b>Don’t take long showers</b> as that can dry out your skin. Also, too much soap can decrease your skin’s natural moisture.",
#               "Use soaps or cleansers that are <b>gentle on the skin</b>. Here are some tips - use ones that do not have beads or other scrub particles, as they can irritate the skin. If your skin is very sensitive to ingredients such as <i>salicylic acid</i>, make sure to read the labels carefully. Do not use your face wash more than once a day for your skin, as that can dry out your skin even more!",
#               "<b>Moisturize</b> after a shower and through the day to help your skin heal. Read labels - they usually let you know what type of skin what moisturizer is for. Your goal is to find ones that are suitable for sensitive skin and for dry skin.",
#               "Avoid medications and products that cause <b>excessive drying</b>, or ensure you moisturise if you need to take medications. Medicines such an antibiotics or even acne medications can dry out your skin. Read side effects of any medicine that you are taking, and ask your doctor if you can take an alternative. However, we realise this is sometimes not possible. So if you need to take these medicines, make sure to moisturize a little extra while you are on the course!",
#             ]
#           }
#         },
#         {
#           :content => "Since your skin is also <b>sensitive</b>, you may have dry areas on your skin, redness and sometimes even itching and burning. ",
#           :things_you_can_do => {
#             :title => "Some things you can do for this:",
#             :content => [
#               "Usually, there is a <b>trigger</b> to this type of skin, and if you do find out what that is, avoid it as soon as possible. The most common trigger is <b>skin care products and makeup</b>, so read your labels carefully! Always watch what you put on your face - whether it is makeup, face washes or even lotions. Read labels to make sure the product is made for sensitive skin - that is key when it comes to your skin type.",
#               "The sun is also a major trigger, so <b>always wear sunscreen</b> even if you're only going out for a short while. UV rays can destroy the texture of your skin and sun burns are just not fun."
#             ]
#           }
#         }
#       ]
#     }
#   },
#   {
#     :category => "skin type quiz",
#     :sub_category => "combination sensitive",
#     :content => {
#       :title =>  "combination sensitive skin",
#       :sub_title => "It seems like you have <b>combination sensitive skin</b>. ",
#       :paras => [
#         {
#           :content => "Since your skin is a <b>combination</b> type, you may have some areas on your face that are oily, while some are dry, with different textures too. The most commonly oily area is your <b>T-zone</b> (which includes the nose, forehead and chin), resulting in your skin appearing shiny. Your <b>pores</b> may look larger and you may have <b>blackheads</b>. Given that your skin has multiple different areas, your skin care routine has to tend to them differently! ",
#           :things_you_can_do => {
#             :title => "Some things you can do for this: ",
#             :content => [
#               "Combination skin is hard to take care of because you have to tend to different areas differently. For oily parts, make sure you <b>wash your face twice daily</b> and more if you go out into the sun. For the dry areas, <b>moisturize</b> with lotion everytime you wash your face so it does not dry out."
#             ]
#           }
#         },
#         {
#           :content => "Since your skin is also <b>sensitive</b>, you may have dry areas on your skin, redness and sometimes even itching and burning. ",
#           :things_you_can_do => {
#             :title => "Some things you can do for this:",
#             :content => [
#               "Usually, there is a <b>trigger</b> to this type of skin, and if you do find out what that is, avoid it as soon as possible. The most common trigger is <b>skin care products and makeup</b>, so read your labels carefully! Always watch what you put on your face - whether it is makeup, face washes or even lotions. Read labels to make sure the product is made for sensitive skin - that is key when it comes to your skin type.",
#               "The sun is also a major trigger, so <b>always wear sunscreen</b> even if you're only going out for a short while. UV rays can destroy the texture of your skin and sun burns are just not fun."
#             ]
#           }
#         }
#       ]
#     }
#   },
#   {
#     :category => "skin type quiz",
#     :sub_category => "normal to oily",
#     :content => {
#       :title =>  "normal to oily skin",
#       :sub_title => "It seems like you have <b>normal to oily skin</b>. ",
#       :paras => [
#         {
#           :content => "You may find that you have enlarged pores and blackheads, pimples and blemishes on your face. Your complexion may be shiny because of the excess oil produced. Besides this, weather, puberty, hormones, and even stress can also cause or contribute to oily skin. ",
#           :things_you_can_do => {
#             :title => "Some things you can do: ",
#             :content => [
#               "<b>Wash your skin regularly</b> - once or twice a day at least,  and more if you are working out / sweating a lot. ",
#               "<b>Use a gentle cleanser / face wash</b> whenever you wash, and do not scrub your face! ",
#               "If you get pimples, <b>do not pop or pick at them</b> - not only does this spread infection, it can leave scars which are very stubborn. ",
#               "Use skin care and cosmetic products that <b>do not clog pores</b> - they are usually labeled as <b>non-comedogenic</b>. "
#             ]
#           }
#         }
#       ]
#     }
#   },
#   {
#     :category => "skin type quiz",
#     :sub_category => "normal to dry",
#     :content => {
#       :title =>  "normal to dry skin",
#       :sub_title => "It seems like you have <b>normal to dry skin</b>. ",
#       :paras => [
#         {
#           :content => "Your skin may have pores that are small, and your skin may have visible lines. You may also have red patches and reduced elasticity in your skin, causing a dull complexion. Dry skin is easily irritated and so it can crack, itch or get inflamed easily. ",
#           :things_you_can_do => {
#             :title => "Some things you can do for this: ",
#             :content => [
#               "<b>Don’t take long showers</b> as that can dry out your skin. Also, too much soap can decrease your skin’s natural moisture.",
#               "Use soaps or cleansers that are <b>gentle on the skin</b>. Here are some tips - use ones that do not have beads or other scrub particles, as they can irritate the skin. If your skin is very sensitive to ingredients such as <i>salicylic acid</i>, make sure to read the labels carefully. Do not use your face wash more than once a day for your skin, as that can dry out your skin even more!",
#               "<b>Moisturize</b> after a shower and through the day to help your skin heal. Read labels - they usually let you know what type of skin what moisturizer is for. Your goal is to find ones that are suitable for sensitive skin and for dry skin.",
#               "Avoid medications and products that cause <b>excessive drying</b>, or ensure you moisturise if you need to take medications. Medicines such an antibiotics or even acne medications can dry out your skin. Read side effects of any medicine that you are taking, and ask your doctor if you can take an alternative. However, we realise this is sometimes not possible. So if you need to take these medicines, make sure to moisturize a little extra while you are on the course!",
#             ]
#           }
#         }
#       ]
#     }
#   },
#   {
#     :category => "skin type quiz",
#     :sub_category => "oily",
#     :content => {
#       :title =>  "oily skin",
#       :sub_title => "It seems like you have <b>oily skin</b>. ",
#       :paras => [
#         {
#           :content => "You may find that you have enlarged pores and blackheads, pimples and blemishes on your face. Your complexion may be shiny because of the excess oil produced. Besides this, weather, puberty, hormones, and even stress can also cause or contribute to oily skin. ",
#           :things_you_can_do => {
#             :title => "Some things you can do: ",
#             :content => [
#               "<b>Wash your skin regularly</b> - once or twice a day at least,  and more if you are working out / sweating a lot. ",
#               "<b>Use a gentle cleanser / face wash</b> whenever you wash, and do not scrub your face! ",
#               "If you get pimples, <b>do not pop or pick at them</b> - not only does this spread infection, it can leave scars which are very stubborn. ",
#               "Use skin care and cosmetic products that <b>do not clog pores</b> - they are usually labeled as <b>non-comedogenic</b>. "
#             ]
#           }
#         }
#       ]
#     }
#   },
#   {
#     :category => "skin type quiz",
#     :sub_category => "dry",
#     :content => {
#       :title =>  "dry skin",
#       :sub_title => "It seems like you have <b>dry skin</b>. ",
#       :paras => [
#         {
#           :content => "Since your skin is <b>dry</b>, your pores are small, and your skin may have visible lines. You may also have red patches and reduced elasticity in your skin, causing a dull complexion. Dry skin is easily irritated and so it can crack, itch or get inflamed easily. ",
#           :things_you_can_do => {
#             :title => "Some things you can do for this: ",
#             :content => [
#               "<b>Don’t take long showers</b> as that can dry out your skin. Also, too much soap can decrease your skin’s natural moisture.",
#               "Use soaps or cleansers that are <b>gentle on the skin</b>. Here are some tips - use ones that do not have beads or other scrub particles, as they can irritate the skin. If your skin is very sensitive to ingredients such as <i>salicylic acid</i>, make sure to read the labels carefully. Do not use your face wash more than once a day for your skin, as that can dry out your skin even more!",
#               "<b>Moisturize</b> after a shower and through the day to help your skin heal. Read labels - they usually let you know what type of skin what moisturizer is for. Your goal is to find ones that are suitable for sensitive skin and for dry skin.",
#               "Avoid medications and products that cause <b>excessive drying</b>, or ensure you moisturise if you need to take medications. Medicines such an antibiotics or even acne medications can dry out your skin. Read side effects of any medicine that you are taking, and ask your doctor if you can take an alternative. However, we realise this is sometimes not possible. So if you need to take these medicines, make sure to moisturize a little extra while you are on the course!",
#             ]
#           }
#         }
#       ]
#     }
#   },
#   {
#     :category => "skin type quiz",
#     :sub_category => "combination",
#     :content => {
#       :title =>  "combination skin",
#       :sub_title => "It seems like you have <b>combination skin</b>. ",
#       :paras => [
#         {
#           :content => "Since your skin is a <b>combination</b> type, you may have some areas on your face that are oily, while some are dry, with different textures too. The most commonly oily area is your <b>T-zone</b> (which includes the nose, forehead and chin), resulting in your skin appearing shiny. Your <b>pores</b> may look larger and you may have <b>blackheads</b>. Given that your skin has multiple different areas, your skin care routine has to tend to them differently! ",
#           :things_you_can_do => {
#             :title => "Some things you can do for this: ",
#             :content => [
#               "Combination skin is hard to take care of because you have to tend to different areas differently. For oily parts, make sure you <b>wash your face twice daily</b> and more if you go out into the sun. For the dry areas, <b>moisturize</b> with lotion everytime you wash your face so it does not dry out."
#             ]
#           }
#         }
#       ]
#     }
#   },
#   {
#     :category => "skin type quiz",
#     :sub_category => "sensitive",
#     :content => {
#       :title =>  "sensitive skin",
#       :sub_title => "It seems like you have <b>sensitive skin</b>. ",
#       :paras => [
#         {
#           :content => "You may have dry areas on your skin, redness and sometimes even itching and burning. ",
#           :things_you_can_do => {
#             :title => "Some things you can do for this: ",
#             :content => [
#               "Usually, there is a <b>trigger</b> to this type of skin, and if you do find out what that is, avoid it as soon as possible. The most common trigger is <b>skin care products and makeup</b>, so read your labels carefully! Always watch what you put on your face - whether it is makeup, face washes or even lotions. Read labels to make sure the product is made for sensitive skin - that is key when it comes to your skin type.",
#               "The sun is also a major trigger, so <b>always wear sunscreen</b> even if you're only going out for a short while. UV rays can destroy the texture of your skin and sun burns are just not fun."
#             ]
#           }
#         }
#       ]
#     }
#   },
#   {
#     :category => "skin type quiz",
#     :sub_category => "normal",
#     :content => {
#       :title =>  "sensitive skin",
#       :sub_title => "It seems like you have <b>normal skin</b>. ",
#       :paras => [
#         {
#           :content => "Your skin has a balance between moisture and oil production; it is neither too dry nor too oily. Your pores are not large and visible, allowing for a smooth complexion. Your skin is probably not sensitive to products or sunlight. ",
#           :things_you_can_do => {
#             :title => "Of course now you have to maintain it! So here are some tips: ",
#             :content => [
#               "<b>Always use sunscreen!</b> Even if you’re going out for a short while, make it part of your daily routine.",
#               "<b>Avoid washing your face too much</b> - this can make it dry. Twice daily works great!",
#               "If you use any <b>cosmetic products</b>, remove them from your face before bed - for example, powders, makeup, etc.",
#             ]
#           }
#         }
#       ]
#     }
#   }
# ])

Questionnaire.create(
  [
    {
      "question" => "$name, we're first going to ask some basic information about you.",
      "desc" => "",
      "answers" => nil,
      "field_type" => "statement",
      "variables" => ["name"]
    },
    {
      "question" => "What's your sex?",
      "desc" => "",
      "answers" =>
      [
        "Male",
        "Female"
      ],
      "field_type" => "radio_other"
    },
    {
      "question" => "How old are you (in years)?",
      "desc" => "For example: 18",
      "answers" => nil,
      "field_type" => "integer"
    },
    {
      "question" => "We are sorry $name, but we cannot treat patients over the age 65 or under 2. Hence, we recommend that you see a doctor in person.",
      "desc" => "",
      "answers" => nil,
      "field_type" => "statement",
      "variables" => ["name"]
    },
    {
      "question" => "If you've entered this in error, please click edit to change your answer",
      "desc" => "",
      "answers" =>
      [
        "Edit",
        "Do not change my answer"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Please tell us if <b>you</b> have a personal history of any of the following conditions.",
      "desc" => 'If you do not have any personal history of any of the below, please select "None of the above".',
      "answers" =>
      [
        "Polycistic Ovarian Disease (PCOD)",
        "Diabetes",
        "Asthma",
        "Hypertension (high blood pressure)",
        "Hyperthyroid",
        "Hypothyroid",
        "Hypercholesterolemia (high cholesterol)",
        "Migraine",
        "Psychiatric problems",
        "Cushing's disease",
        "Ovarian tumours",
        "Androgen secreting tumours",
        "Adrenal hyperplasia",
        "None of the above"
      ],
      "field_type" => "select_all"
    },
    {
      "question" => "Please tell us if <b>anyone in your family</b> has a history of any of the following conditions.",
      "desc" => 'If nobody in your family has a history of any of the below, please select "None of the above".',
      "answers" =>
      [
        "Polycistic Ovarian Disease (PCOD)",
        "Diabetes",
        "Asthma",
        "Hypertension (high blood pressure)",
        "Hyperthyroid",
        "Hypothyroid",
        "Hypercholesterolemia (high cholesterol)",
        "Migraine",
        "Psychiatric problems",
        "Cushing's disease",
        "Ovarian tumours",
        "Androgen secreting tumours",
        "Adrenal hyperplasia",
        "None of the above"
      ],
      "field_type" => "select_all"
    },
    {
      "question" => "Do you have a personal or family history of skin cancer?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "We are sorry $name, since you have a personal or family history of skin cancer, we won't be to treat you. We recommend that you see a doctor in person.",
      "desc" => "",
      "answers" => nil,
      "field_type" => "statement",
      "variables" => ["name"]
    },
    {
      "question" => "If you've entered this in error, please click edit to change your answer",
      "desc" => "",
      "answers" =>
      [
        "Edit",
        "Do not change my answer"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Thanks, $name. Now it would be great if you can help us understand more about your acne.",
      "desc" => "",
      "answers" => nil,
      "field_type" => "statement",
      "variables" => ["name"]
    },
    {
      "question" => "$name, where are you experiencing the acne?",
      "desc" => "",
      "answers" =>
      [
        "Face - forehead",
        "Face - cheeks",
        "Face - jawline",
        "Scalp",
        "Chest",
        "Back",
        "Shoulders"
      ],
      "field_type" => "select_all",
      "variables" => ["name"]
    },
    {
      "question" => "You will need to provide us with a photo of your face <b>from front on.</b>",
      "desc" => "Make sure there is plenty of light. Keep the phone 20cm from you, and use the back camera if possible. Pull your hair back and ensure your full face is visible.",
      "answers" => nil,
      "field_type" => "statement_image",
      "image" => "https://s3-ap-southeast-1.amazonaws.com/remedicohealth/assets/images/upload_image_front.png"
    },
    {
      "question" => "Please take or attach a photo of your face <b>from front on</b>.",
      "desc" => "If you can't take one right now, you can send it to us later.",
      "answers" => nil,
      "field_type" => "image_upload",
    },
    {
      "question" => "You will need to provide us with a photo of your face <b>from your left profile</b>.",
      "desc" => "Make sure there is plenty of light. Keep the phone 20cm from you, and use the back camera if possible. Ensure your profile is fully visible. If hair is covering part of your face, hold it up as shown.",
      "answers" => nil,
      "field_type" => "statement_image",
      "image" => "https://s3-ap-southeast-1.amazonaws.com/remedicohealth/assets/images/upload_image_left.png"
    },
    {
      "question" => "Please take or attach a photo of your face <b>from your left profile</b>.",
      "desc" => "If you can't take one right now, you can send it to us later.",
      "answers" => nil,
      "field_type" => "image_upload",
    },
    {
      "question" => "You will need to provide us with a photo of your face <b>from your right profile</b>.",
      "desc" => "Make sure there is plenty of light. Keep the phone 20cm from you, and use the back camera if possible. Ensure your profile is fully visible. If hair is covering part of your face, hold it up as shown.",
      "answers" => nil,
      "field_type" => "statement_image",
      "image" => "https://s3-ap-southeast-1.amazonaws.com/remedicohealth/assets/images/upload_image_right.png",
    },
    {
      "question" => "Please take or attach a photo of your face <b>from your right profile</b>.",
      "desc" => "If you can't take one right now, you can send it to us later.",
      "answers" => nil,
      "field_type" => "image_upload"
    },
    {
      "question" => "Please take or attach a photo of the acne on your chest.",
      "desc" => "If you can't take a photo right now, you can send it to us later.",
      "answers" => nil,
      "field_type" => "image_upload"
    },
    {
      "question" => "Please take or attach a photo of the acne on your <b>back</b>.",
      "desc" => "If you can't take a photo right now, you can send it to us later.",
      "answers" => nil,
      "field_type" => "image_upload"
    },
    {
      "question" => "Please take or attach a photo of the acne on your <b>shoulders</b>.",
      "desc" => "If you can't take a photo right now, you can send it to us later.",
      "answers" => nil,
      "field_type" => "image_upload"
    },
    {
      "question" => "Which face products do you use (select and specify all that apply): ",
      "desc" => "",
      "answers" =>
      [
        "Face wash",
        "Sunscreen",
        "Day cream",
        "Night cream",
        "Medicated cream",
        "None of the above",
      ],
      "field_type" => "select_all"
    },
    {
      "question" => "Which brand / type of facewash do you use?",
      "desc" => "",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "Which brand / type of sunscreen do you use?",
      "desc" => "",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "Which brand / type of day cream do you use on your face?",
      "desc" => "",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "Which brand / type of night cream do you use on your face?",
      "desc" => "",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "Which brand / type of medicated cream do you use on your face?",
      "desc" => "",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "Thanks, $name",
      "desc" => "",
      "answers" => nil,
      "field_type" => "statement",
      "variables" => ["name"]
    },
    {
      "question" => "Are you pregnant and / or lactating?",
      "desc" => "",
      "answers" =>
      [
        "Pregnant",
        "Lactating",
        "Pregnant and lactating",
        "Not pregnant or lactating"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "You mentioned that you have a personal history of PCOD. Do you still have it?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Which medications are you currently taking for it?",
      "desc" => "",
      "answers" =>
      [
        "Oral contraceptive pills with oestrogen and progesterone (combined pill)",
        "Oral contraceptive pills with oestrogen and cyproterone acetate",
        "Finasteride",
        "Cytomid",
        "Metformin",
        "I'm not taking any medications for PCOD"
      ],
      "field_type" => "select_all_other"
    },
    {
      "question" => "Do you experience any of the following symptoms?",
      "desc" => "",
      "answers" =>
      [
        "Irregular periods",
        "Thinning of scalp hair",
        "Facial hair",
        "Weight gain in a short time",
        "None of the above"
      ],
      "field_type" => "select_all"
    },
    {
      "question" => "Do you have a family history of acne?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "When did your <b>current acne breakout</b> start, $name?",
      "desc" => "We only need to know about the acne you have right now. If you have had acne breakouts in the past, you can tell us about those in later questions.",
      "answers" =>
      [
        "Less than 1 week ago",
        "1 - 3 weeks ago",
        "3 weeks to 2 months ago",
        "2 months to 1 year ago",
        "Longer than 1 year ago"
      ],
      "field_type" => "radio",
      "variables" => ["name"]
    },
    {
      "question" => "Have you had acne breakouts before?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "How old were you when you first had acne?",
      "desc" => "",
      "answers" =>
      [
        "Less than 20 years old",
        "20 - 30 years old",
        "30 - 40 years old",
        "2 months to 1 year ago",
        "Older than 40 years old"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Have you taken any of the following oral treatments (in the past or currently) for your acne?",
      "desc" => "",
      "answers" =>
      [
        "Isotretinoin",
        "Oral contraceptive pills",
        "Azithromycin / Roxithromycin",
        "Minocycline / Doxycycline",
        "Oral steroids",
        "None of the above"
      ],
      "field_type" => "select_all"
    },
    {
      "question" => "How long did you take the Isotretinoin for?",
      "desc" => "",
      "answers" =>
      [
        "Less than 3 months",
        "3 - 6 months",
        "6 - 12 months",
        "Longer than 12 months",
        "I am still taking it"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Did the Isotretinoin help improve your acne?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "When did your Isotretinoin course end?",
      "desc" => "",
      "answers" =>
      [
        "Longer than 12 months ago",
        "6 - 12 months",
        "Less than 6 months ago",
        "I am still taking the treatment"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "How long did you take the oral contraceptive pills for?",
      "desc" => "",
      "answers" =>
      [
        "Less than 3 months",
        "3 - 6 months",
        "6 - 12 months",
        "Longer than 12 months",
        "I am still taking it"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Did the oral contraceptive pills help improve your acne?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "When did your oral contraceptive pill course end?",
      "desc" => "",
      "answers" =>
      [
        "Longer than 12 months ago",
        "6 - 12 months",
        "Less than 6 months ago",
        "I am still taking the treatment"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "How long did you take the Azithromycin / Roxithromycin for?",
      "desc" => "",
      "answers" =>
      [
        "Less than 1 month",
        "1 -3 months",
        "Longer than 3 months",
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Did the Azithromycin / Roxithromycin help improve your acne?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "When did your Azithromycin / Roxithromycin course end?",
      "desc" => "",
      "answers" =>
      [
        "Longer than 12 months ago",
        "6 - 12 months",
        "Less than 6 months ago",
        "I am still taking the treatment"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "How long did you take the Minocycline / Doxycycline for?",
      "desc" => "",
      "answers" =>
      [
        "Less than 1 month",
        "1 -3 months",
        "Longer than 3 months",
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Did the Minocycline / Doxycycline help improve your acne?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "When did your Minocycline / Doxycycline course end?",
      "desc" => "",
      "answers" =>
      [
        "Longer than 12 months ago",
        "6 - 12 months",
        "Less than 6 months ago",
        "I am still taking the treatment"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "How long did you take the oral steroids for?",
      "desc" => "",
      "answers" =>
      [
        "Less than 3 months",
        "3 - 6 months",
        "6 - 12 months",
        "Longer than 12 months",
        "I am still taking it"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Did the oral steroids help improve your acne?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "When did your oral steroids course end?",
      "desc" => "",
      "answers" =>
      [
        "Longer than 12 months ago",
        "6 - 12 months",
        "Less than 6 months ago",
        "I am still taking the treatment"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Have you experienced any recent stress of the following kind?",
      "desc" => "",
      "answers" =>
      [
        "Physical - recent illness",
        "Physical - travel",
        "Physical - decreased sleep",
        "Physical - decreased appetite",
        "Physical - excessive junk food or sugar in diet",
        "Mental",
        "No recent physical or mental stress"
      ],
      "field_type" => "select_all"
    },
    {
      "question" => "Almost there, $name! We need to ask you a few final questions about you and your lifestyle. This will help us to complete our patient profile, and to prepare a treatment plan for you.",
      "desc" => "",
      "answers" => nil,
      "field_type" => "statement",
      "variables" => ["name"]
    },
    {
      "question" => "What is your ethnicity / racial background?",
      "desc" => "",
      "answers" =>
      [
        "Indian / South Asian",
        "Caucasian (e.g. European)",
        "African",
        "Middle Eastern",
        "South East Asian (e.g. Thai, Vietnamese)",
        "East Asian (e.g. Chinese, Korean, Japanese)",
        "South or Central American"
      ],
      "field_type" => "radio_other"
    },
    {
      "question" => "Which city do you live in?",
      "desc" => "Where you live affects the type of weather your skin is exposed to.",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "What's your occupation?",
      "desc" => "We need to know what kind of conditions your skin is exposed to daily.",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "Are you married and / or do you have any sexual partners?",
      "desc" => "We need to ask this for legal reasons. As with all of our questions, we won't disclose it to anyone else.",
      "answers" =>
      [
        "Married",
        "Unmarried, with sexual partner(s)",
        "Unmarried, with no sexual partners"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "How much do you weigh (in kilograms)?",
      "desc" => "We need this information so we can prescribe the right dosage for you, in case you need any medications.",
      "answers" => nil,
      "field_type" => "integer"
    },
    {
      "question" => "Do you have any drug allergies?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Which drug allergies are those?",
      "desc" => "",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "Do you have any food allergies?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Which food allergies are those?",
      "desc" => "",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "Are you currently on any medication (other than what you've already told us)?",
      "desc" => "",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Let us know which medications you are taking, and how long you've been taking them for.",
      "desc" => "For example: Glycomet, since 3 months.",
      "answers" =>
      [ "Yes",
        "No"
      ],
      "field_type" => "radio"
    },
    {
      "question" => "How many times per week do you drink alcohol?",
      "desc" => "Understanding your lifestyle and habits help us understand your skin.",
      "answers" =>
      [ "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "I drink occasionally",
        "I don't drink alcohol",
      ],
      "field_type" => "radio"
    },
    {
      "question" => "How many cigarettes do you smoke per day?",
      "desc" => "Understanding your lifestyle and habits helps us understand your skin.",
      "answers" =>
      [ "1 - 5",
        "5 - 20",
        "More than 20",
        "I smoke occasionally",
        "I don't smoke cigarettes",
      ],
      "field_type" => "radio"
    },
    {
      "question" => "Great! Lastly, let us know your email ID.",
      "desc" => "We will send your treatment plan to this address, once your dermatologist has prepared it.",
      "answers" => nil,
      "field_type" => "string"
    },
    {
      "question" => "Let us know if there are any other comments or information you would like to provide about yourself or your symptoms.",
      "desc" => "Also let us know if you were referred to a specific doctor. If you don't have anything more to provide, just leave the box blank.",
      "answers" => nil,
      "field_type" => "long_string"
    },
    {
      "question" => "",
      "desc" => "",
      "answers" => nil,
      "field_type" => "submit"
    }
  ]
);

def get_questionnaire_by_contains pattern
  Questionnaire.find_by("question like ?", pattern)
end

QuestionnaireLogic.create([
    {
        questionnaire: get_questionnaire_by_contains("%we're first going to ask some basic information about you%"),
        go_to:
        [
          get_questionnaire_by_contains("%What's your sex%").id
        ],
        entry_type: :start
    },
    {
        questionnaire: get_questionnaire_by_contains("%What's your sex%"),
        is_mandatory: true,
        go_to:
        [
          get_questionnaire_by_contains("%How old are you%").id
        ],
    },
    {
      questionnaire: get_questionnaire_by_contains("%How old are you%"),
      is_mandatory: true,
      requires_check: true,
      jump_logic: {
        "if": [{
          "<": [2, {
            "var": "value"
          }, 66]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%How old are you%").id
      },
      static_params: {
        "value_t": [get_questionnaire_by_contains("%if <b>you</b> have a personal history of any of the following conditions.%").id],
        "value_f": [
          get_questionnaire_by_contains("%We are sorry $name, but we cannot treat patients over the age 65 or under 2%").id,
          Questionnaire.where("question like ?", "%If you've entered this in error%").first.id
        ]
      },
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%We are sorry $name, but we cannot treat patients over the age 65 or under 2%")
    },
    {
      questionnaire: Questionnaire.where("question like ?", "%If you've entered this in error%").first,
      is_mandatory: true,
      requires_check: true,
      jump_logic: {
        "if": [{
          "==": [{
            "var": "value"
          }, "Edit"]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": Questionnaire.where("question like ?", "%If you've entered this in error%").first.id
      },
      static_params: {
        "value_t": [get_questionnaire_by_contains("%How old are you%").id],
        "value_f": [get_questionnaire_by_contains("").id]
      },
      entry_type: :edit,
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%if <b>you</b> have a personal history of any of the following conditions.%"),
      is_mandatory: true,
      go_to:
      [
        get_questionnaire_by_contains("%if <b>anyone in your family</b> has a history of any of the following conditions.%").id
      ]
    },
    {
      questionnaire: get_questionnaire_by_contains("%if <b>anyone in your family</b> has a history of any of the following conditions%"),
      is_mandatory: true,
      go_to:
      [
        get_questionnaire_by_contains("%Do you have a personal or family history of skin cancer?%").id
      ]
    },
    {
      questionnaire: get_questionnaire_by_contains("%Do you have a personal or family history of skin cancer?%"),
      is_mandatory: true,
      requires_check: true,
      jump_logic: {
        "if": [{
          "==": [{
            "var": "value"
          }, "No"]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%Do you have a personal or family history of skin cancer?%").id
      },
      static_params: {
        "value_t":
        [
          get_questionnaire_by_contains("%Thanks, $name. Now it would be great if you can help us understand more about your acne.%").id
        ],
        "value_f":
        [
          get_questionnaire_by_contains("%We are sorry $name, since you have a personal or family history of skin cancer, we won't be to treat you. We recommend that you see a doctor in person.%").id,
          Questionnaire.where("question like ?", "%If you've entered this in error%").second.id
        ]
      },
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%We are sorry $name, since you have a personal or family history of skin cancer, we won't be to treat you. We recommend that you see a doctor in person.%"),
    },
    {
      questionnaire: Questionnaire.where("question like ?", "%If you've entered this in error%").second,
      is_mandatory: true,
      requires_check: true,
      jump_logic: {
        "if": [{
          "==": [{
            "var": "value"
          }, "Edit"]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": Questionnaire.where("question like ?", "%If you've entered this in error%").second.id
      },
      static_params: {
        "value_t": [get_questionnaire_by_contains("%Do you have a personal or family history of skin cancer?%").id],
        "value_f": [get_questionnaire_by_contains("").id]
      },
      entry_type: :edit,
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%Thanks, $name. Now it would be great if you can help us understand more about your acne.%"),
      go_to: [get_questionnaire_by_contains("%$name, where are you experiencing the acne?%").id]
    },
    {
      questionnaire: get_questionnaire_by_contains("%$name, where are you experiencing the acne?%"),
      is_mandatory: true,
      requires_check: true,
      jump_logic: {
        "merge": [{
          "if": [{
              "in": ["Face - forehead", {
                "var": "value"
              }]
            }, {
              "var": "value_face_forehead"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Face - cheeks", {
                "var": "value"
              }]
            }, {
              "var": "value_face_cheeks"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Face - jawline", {
                "var": "value"
              }]
            }, {
              "var": "value_face_jawline"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Scalp", {
                "var": "value"
              }]
            }, {
              "var": "value_scalp"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Chest", {
                "var": "value"
              }]
            }, {
              "var": "value_chest"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Back", {
                "var": "value"
              }]
            }, {
              "var": "value_back"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Shoulders", {
                "var": "value"
              }]
            }, {
              "var": "value_shoulders"
            },
            []
          ]
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%$name, where are you experiencing the acne?%").id
      },
      static_params: {
        "value_face_forehead":
        [
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from front on.</b>%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from front on</b>.%").id,
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your left profile</b>.%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your left profile</b>.%").id,
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your right profile</b>.%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your right profile</b>.%").id
        ],
        "value_face_cheeks":
        [
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from front on.</b>%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from front on</b>.%").id,
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your left profile</b>.%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your left profile</b>.%").id,
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your right profile</b>.%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your right profile</b>.%").id
        ],
        "value_face_jawline":
        [
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from front on.</b>%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from front on</b>.%").id,
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your left profile</b>.%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your left profile</b>.%").id,
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your right profile</b>.%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your right profile</b>.%").id
        ],
        "value_scalp":
        [
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from front on.</b>%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from front on</b>.%").id,
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your left profile</b>.%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your left profile</b>.%").id,
          get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your right profile</b>.%").id,
          get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your right profile</b>.%").id
        ],
        "value_chest": [get_questionnaire_by_contains("%Please take or attach a photo of the acne on your chest.%").id],
        "value_back": [get_questionnaire_by_contains("%Please take or attach a photo of the acne on your <b>back</b>.%").id],
        "value_shoulders": [get_questionnaire_by_contains("%Please take or attach a photo of the acne on your <b>shoulders</b>.%").id]
      },
      go_to: [get_questionnaire_by_contains("%Which face products do you use (select and specify all that apply): %").id],
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from front on.</b>"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from front on</b>."),
      save_checkpoint: true},
    {
      questionnaire: get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your left profile</b>.%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your left profile</b>."),
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%You will need to provide us with a photo of your face <b>from your right profile</b>."),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Please take or attach a photo of your face <b>from your right profile</b>."),
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%Please take or attach a photo of the acne on your chest."),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Please take or attach a photo of the acne on your <b>back</b>."),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Please take or attach a photo of the acne on your <b>shoulders</b>."),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Which face products do you use (select and specify all that apply): "),
      is_mandatory: true,
      requires_check: true,
      jump_logic: {
        "merge": [{
          "if": [{
              "in": ["Face wash", {
                "var": "value"
              }]
            }, {
              "var": "value_facewash"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Sunscreen", {
                "var": "value"
              }]
            }, {
              "var": "value_sunscreen"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Day cream", {
                "var": "value"
              }]
            }, {
              "var": "value_day_cream"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Night cream", {
                "var": "value"
              }]
            }, {
              "var": "value_night_cream"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Medicated cream", {
                "var": "value"
              }]
            }, {
              "var": "value_medicated_cream"
            },
            []
          ]
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%Which face products do you use (select and specify all that apply): ").id
      },
      static_params: {
        "value_facewash": [get_questionnaire_by_contains("%Which brand / type of facewash do you use%").id],
        "value_sunscreen": [get_questionnaire_by_contains("%Which brand / type of sunscreen do you use%").id],
        "value_day_cream": [get_questionnaire_by_contains("%Which brand / type of day cream do you use on your face%").id],
        "value_night_cream": [get_questionnaire_by_contains("%Which brand / type of night cream do you use on your face%").id],
        "value_medicated_creams": [get_questionnaire_by_contains("%Which brand / type of medicated cream do you use on your face%").id],
      },
      go_to: [get_questionnaire_by_contains("%Thanks, $name").id],
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%Which brand / type of facewash do you use%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Which brand / type of sunscreen do you use%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Which brand / type of day cream do you use on your face%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Which brand / type of night cream do you use on your face%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Which brand / type of medicated cream do you use on your face%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Thanks, $name"),
      requires_check: true,
      jump_logic: {
        "if": [{
          "==": [{
            "var": "value"
          }, "Female"]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%What's your sex?%").id
      },
      static_params: {
        "value_t": [get_questionnaire_by_contains("%Are you pregnant and / or lactating?%").id],
        "value_f": [get_questionnaire_by_contains("%Do you have a family history of acne?%").id]
      },
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%Are you pregnant and / or lactating?%"),
      is_mandatory: true,
      requires_check: true,
      jump_logic: {
        "merge": [{
          "if": [{
              "in": ["Polycistic Ovarian Disease (PCOD)", {
                "var": "value"
              }]
            }, {
              "var": "value_pcod"
            },
            []
          ]
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%Please tell us if <b>you</b> have a personal history of any of the following conditions.%").id
      },
      static_params: {
        "value_pcod": [get_questionnaire_by_contains("%You mentioned that you have a personal history of PCOD. Do you still have it?%").id],
      },
      go_to: [get_questionnaire_by_contains("%Do you experience any of the following symptoms%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%You mentioned that you have a personal history of PCOD. Do you still have it?%"),
      requires_check: true,
      jump_logic: {
        "if": [{
          "==": [{
            "var": "value"
          }, "Yes"]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%You mentioned that you have a personal history of PCOD. Do you still have it?%").id
      },
      static_params: {
        "value_t": [get_questionnaire_by_contains("%Which medications are you currently taking for it?%").id],
        "value_f": [get_questionnaire_by_contains("%Do you experience any of the following symptoms%").id]
      },
    },
    {
      questionnaire: get_questionnaire_by_contains("%Which medications are you currently taking for it?%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Do you experience any of the following symptoms%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%Do you experience any of the following symptoms%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Do you have a family history of acne?%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%Do you have a family history of acne?%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%When did your <b>current acne breakout</b> start, $name%").id],
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%When did your <b>current acne breakout</b> start, $name%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Have you had acne breakouts before%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%Have you had acne breakouts before%"),
      requires_check: true,
      jump_logic: {
        "if": [{
          "==": [{
            "var": "value"
          }, "Yes"]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%Have you had acne breakouts before%").id
      },
      static_params: {
        "value_t": [get_questionnaire_by_contains("%How old were you when you first had acne?%").id],
        "value_f": [get_questionnaire_by_contains("%Have you taken any of the following oral treatments (in the past or currently) for your acne?%").id]
      },
    },
    {
      questionnaire: get_questionnaire_by_contains("%How old were you when you first had acne?%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Have you taken any of the following oral treatments (in the past or currently) for your acne?%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%Have you taken any of the following oral treatments (in the past or currently) for your acne?%"),
      is_mandatory: true,
      requires_check: true,
      jump_logic: {
        "merge": [{
          "if": [{
              "in": ["Isotretinoin", {
                "var": "value"
              }]
            }, {
              "var": "value_isotretinoin"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Oral contraceptive pills", {
                "var": "value"
              }]
            }, {
              "var": "value_oral_contraceptive_pills"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Azithromycin / Roxithromycin", {
                "var": "value"
              }]
            }, {
              "var": "value_azithromycin_roxithromycin"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Minocycline / Doxycycline", {
                "var": "value"
              }]
            }, {
              "var": "value_minocycline_doxycycline"
            },
            []
          ]
        }, {
          "if": [{
              "in": ["Oral steroids", {
                "var": "value"
              }]
            }, {
              "var": "value_oral_steroids"
            },
            []
          ]
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%Have you taken any of the following oral treatments (in the past or currently) for your acne?%").id
      },
      static_params: {
        "value_isotretinoin":
        [
          get_questionnaire_by_contains("%How long did you take the Isotretinoin for%").id,
          get_questionnaire_by_contains("%Did the Isotretinoin help improve your acne?%").id,
          get_questionnaire_by_contains("%When did your Isotretinoin course end%").id
        ],
        "value_oral_contraceptive_pills": [
          get_questionnaire_by_contains("%How long did you take the oral contraceptive pills for%").id,
          get_questionnaire_by_contains("%Did the oral contraceptive pills help improve your acne?%").id,
          get_questionnaire_by_contains("%When did your oral contraceptive pill course end%").id
        ],
        "value_azithromycin_roxithromycin": [
          get_questionnaire_by_contains("%How long did you take the Azithromycin / Roxithromycin for%").id,
          get_questionnaire_by_contains("%Did the Azithromycin / Roxithromycin help improve your acne%").id,
          get_questionnaire_by_contains("%When did your Azithromycin / Roxithromycin course end%").id
        ],
        "value_minocycline_doxycycline": [
          get_questionnaire_by_contains("%How long did you take the Minocycline / Doxycycline for%").id,
          get_questionnaire_by_contains("%Did the Minocycline / Doxycycline help improve your acne?%").id,
          get_questionnaire_by_contains("%When did your Minocycline / Doxycycline course end?%").id
        ],
        "value_oral_steroids": [
          get_questionnaire_by_contains("%How long did you take the oral steroids for%").id,
          get_questionnaire_by_contains("%Did the oral steroids help improve your acne?%").id,
          get_questionnaire_by_contains("%When did your oral steroids course end?%").id
        ],
      },
      go_to: [get_questionnaire_by_contains("%Have you experienced any recent stress of the following kind%").id]
    },
    {
      questionnaire: get_questionnaire_by_contains("%How long did you take the Isotretinoin for%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Did the Isotretinoin help improve your acne?%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%When did your Isotretinoin course end%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%How long did you take the oral contraceptive pills for%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Did the oral contraceptive pills help improve your acne?%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%When did your oral contraceptive pill course end%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%How long did you take the Azithromycin / Roxithromycin for%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Did the Azithromycin / Roxithromycin help improve your acne%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%When did your Azithromycin / Roxithromycin course end%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%How long did you take the Minocycline / Doxycycline for%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Did the Minocycline / Doxycycline help improve your acne?%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%When did your Minocycline / Doxycycline course end?%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%How long did you take the oral steroids for%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Did the oral steroids help improve your acne?%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%When did your oral steroids course end?%"),
    },
    {
      questionnaire: get_questionnaire_by_contains("%Have you experienced any recent stress of the following kind%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Almost there, $name! We need to ask you a few final questions about you and your lifestyle. This will help us to complete our patient profile, and to prepare a treatment plan for you%").id],
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%Almost there, $name! We need to ask you a few final questions about you and your lifestyle. This will help us to complete our patient profile, and to prepare a treatment plan for you."),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%What is your ethnicity / racial background%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%What is your ethnicity / racial background%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Which city do you live in%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%Which city do you live in%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%What's your occupation%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%What's your occupation%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Are you married and / or do you have any sexual partners%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%Are you married and / or do you have any sexual partners%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%How much do you weigh (in kilograms)%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%How much do you weigh (in kilograms)%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Do you have any drug allergies?%").id],
    },
    {
      questionnaire: get_questionnaire_by_contains("%Do you have any drug allergies?%"),
      requires_check: true,
      jump_logic: {
        "if": [{
          "==": [{
            "var": "value"
          }, "Yes"]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%Do you have any drug allergies?%").id
      },
      static_params: {
        "value_t": [get_questionnaire_by_contains("%Which drug allergies are those%").id],
        "value_f": [get_questionnaire_by_contains("%Do you have any food allergies?%").id]
      },
    },
    {
      questionnaire:  get_questionnaire_by_contains("%Which drug allergies are those%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Do you have any food allergies?%").id]
    },
    {
      questionnaire: get_questionnaire_by_contains("%Do you have any food allergies?%"),
      requires_check: true,
      jump_logic: {
        "if": [{
          "==": [{
            "var": "value"
          }, "Yes"]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%Do you have any food allergies?%").id
      },
      static_params: {
        "value_t": [get_questionnaire_by_contains("%Which food allergies are those%").id],
        "value_f": [get_questionnaire_by_contains("%Are you currently on any medication (other than what you've already told us)?%").id]
      },
    },
    {
      questionnaire: get_questionnaire_by_contains("%Which food allergies are those%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Are you currently on any medication (other than what you've already told us)?%").id]
    },
    {
      questionnaire: get_questionnaire_by_contains("%Are you currently on any medication (other than what you've already told us)?%"),
      requires_check: true,
      jump_logic: {
        "if": [{
          "==": [{
            "var": "value"
          }, "Yes"]
        }, {
          "var": "value_t"
        }, {
          "var": "value_f"
        }]
      },
      dynamic_params: {
        "value": get_questionnaire_by_contains("%Are you currently on any medication (other than what you've already told us)?%").id
      },
      static_params: {
        "value_t": [get_questionnaire_by_contains("%Let us know which medications you are taking, and how long you've been taking them for.%").id],
        "value_f": [get_questionnaire_by_contains("%How many times per week do you drink alcohol?%").id]
      },
      save_checkpoint: true
    },
    {
      questionnaire: get_questionnaire_by_contains("%Let us know which medications you are taking, and how long you've been taking them for.%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%How many times per week do you drink alcohol?%").id]
    },
    {
      questionnaire: get_questionnaire_by_contains("%How many times per week do you drink alcohol?%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%How many cigarettes do you smoke per day?%").id]
    },
    {
      questionnaire: get_questionnaire_by_contains("%How many cigarettes do you smoke per day?%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Great! Lastly, let us know your email ID.%").id]
    },
    {
      questionnaire: get_questionnaire_by_contains("%Great! Lastly, let us know your email ID.%"),
      is_mandatory: true,
      go_to: [get_questionnaire_by_contains("%Let us know if there are any other comments or information you would like to provide about yourself or your symptoms.%").id]
    },
    {
      questionnaire: get_questionnaire_by_contains("%Let us know if there are any other comments or information you would like to provide about yourself or your symptoms.%"),
      go_to: [get_questionnaire_by_contains("").id]
    },
    {
      questionnaire: get_questionnaire_by_contains(""),
      entry_type: :end
    }
]);



print i
puts " entries created"
