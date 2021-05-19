#include <catch2/catch_test_macros.hpp>
#include <catch2/benchmark/catch_benchmark.hpp>

#include <version.hh>

TEST_CASE("", ""){
  SECTION(""){
    REQUIRE(true);
    CHECK(true);
    // test contents of version?
    CHECK(*Version::version.branch != '\0');
  }

  BENCHMARK(""){
    for(const auto& i : {0, 1, 2, 3, 4, 5}){
      // :shrug:
    }
  }
}
