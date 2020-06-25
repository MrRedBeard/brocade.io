# brocade.io

Open GTIN / barcode &amp; product database

## Project Background

Over the years there have been several attempts at creating a freely accessible database of GTIN/barcodes and associated product data.

Many of these projects have either stalled or disappeared: the [Outpan API](https://www.outpan.com/developers.php) vanished without warning, [Open Product Data](http://product-open-data.com/download) doesn't appear to have been updated since 2014 and recently [Datakick](https://www.datakick.org/) announced they will be shutting down as of March 31, 2020.

There are still numerous commercial providers, but the number of freely accessible product data sources seems to be severely limited, with the [Internet UPC Database](https://www.upcdatabase.com/) being one of the few open services able to sustain itself. For a universal dataset, UPC and related data isn't universally accessible.

## Project Goals

### Open Access

The project aims to present as few barriers as possible to accessing GTIN and product data. The code for providing the service will be released as open source (see LICENSE for details) and wherever possible the data will be made available under open licenses.

There may be a need to apply some constraints - _e.g._ rate limiting or requiring authorisation for certain tasks - but these will only be introduced for the sake of performance, security or similar concerns.

### Federated/Distributed Data

The project _is not_ intended to be a single source of truth for product data. Instead the goal is to provide a framework for sharing product data between otherwise autonomous sources.

It's anticipated that the project will require novel protocols for federating data between disparate systems, and will be looking for inspiration from other distributed systems (_e.g._ DNS, Open Social, _etc_).

### Migration Path

The initial goal for this project is to establish a migration path for users of existing APIs - notably Datakick. One aim is to provide a Datakick-compatible endpoint for developers of Datakick-related libraries to target.

The database will be seeded using data sourced from Datakick, at least initially.

## Getting Started

This section will have to be added to as the project proceeds, but for now assume a technology stack based around Ruby on Rails and Postgres.

Assuming you're able to get the app installed, there is a basic seed file available using a recent download from
datakick.org. Install the data via the rake task:

```
[bundle exec] rails db:seed:datakick
```

NB There are about 6000 entries in the seed data, but it doesn't include any images.

## Header Pagination Info
### Header - `links` - First Header
<https://www.brocade.io/api/items?page=20&query=peanut+butter>; rel="last", <https://www.brocade.io/api/items?page=2&query=peanut+butter>; rel="next"
### Header - `links` - Following Headers include the previous and
<https://www.brocade.io/api/items?page=1&query=peanut+butter>; rel="first", <https://www.brocade.io/api/items?page=1&query=peanut+butter>; rel="prev", 

### Header - `per-page` & `total`
`per-page` - Results per page = 100
`total` - Total number records = 1912
`total` / `per-page` = Total Pages 19.12 rounded up = 20. Total is also found in Header - `links`  `last`

## Data Types 

```
**Key					DataType**
ProductID				int
gtin14					string
brand_name				string
name					string
fat					string
size					string
fiber					string
sodium					string
sugars					string
protein					string
calories				string
potassium				string
cholesterol				string
ingredients				string
carbohydrate				string
fat_calories				string
serving_size				string
saturated_fat				string
trans_fat				string
monounsaturated_fat			string
polyunsaturated_fat			string
servings_per_container			string
pages					string
author					string
format					string
publisher				string
alcohol_by_volume			double
alcohol_by_weight			double
volume_fluid_ounce			double
volume_ml				double
weight_g				double
weight_ounce				double
unit_count				double
```

## Example JS Class of Data Structure 
```
class clsProducts
{
	constructor()
	{
		this.gtin14 = '';
		this.brand_name = '';
		this.name = '';
		this.fat = '';
		this.size = '';
		this.fiber = '';
		this.sodium = '';
		this.sugars = '';
		this.protein = '';
		this.calories = '';
		this.potassium = '';
		this.cholesterol = '';
		this.ingredients = '';
		this.carbohydrate = '';
		this.fat_calories = '';
		this.serving_size = '';
		this.saturated_fat = '';
		this.trans_fat = '';
		this.monounsaturated_fat = '';
		this.polyunsaturated_fat = '';
		this.servings_per_container = '';
		this.pages = '';
		this.author = '';
		this.format = '';
		this.publisher = '';
		this.alcohol_by_volume = null; //Double
		this.alcohol_by_weight = null; //Double
		this.volume_fluid_ounce = null; //Double
		this.volume_ml = null; //Double
		this.weight_g = null; //Double
		this.weight_ounce = null; //Double
		this.unit_count = null; //Double
	}
}
```

## Example c\# Class of Data Structure 
```
public class Products
    {
        public string gtin14 { get; set; }
        public string brand_name { get; set; }
        public string name { get; set; }
        public string fat { get; set; }
        public string size { get; set; }
        public string fiber { get; set; }
        public string sodium { get; set; }
        public string sugars { get; set; }
        public string protein { get; set; }
        public string calories { get; set; }
        public string potassium { get; set; }
        public string cholesterol { get; set; }
        public string ingredients { get; set; }
        public string carbohydrate { get; set; }
        public string fat_calories { get; set; }
        public string serving_size { get; set; }
        public string saturated_fat { get; set; }
        public string trans_fat { get; set; }
        public string monounsaturated_fat { get; set; }
        public string polyunsaturated_fat { get; set; }
        public string servings_per_container { get; set; }
        public string pages { get; set; }
        public string author { get; set; }
        public string format { get; set; }
        public string publisher { get; set; }
        public double? alcohol_by_volume { get; set; }
        public double? alcohol_by_weight { get; set; }
        public double? volume_fluid_ounce { get; set; }
        public double? volume_ml { get; set; }
        public double? weight_g { get; set; }
        public double? weight_ounce { get; set; }
        public double? unit_count { get; set; }
    }
```


## TODO

* Basic auth / accounts
* Add support for adding / modifying records
* Import image data from Datakick (check with @ankane first)
* Source more open product data
* Front-end UI
* New `/products` endpoint with more features
