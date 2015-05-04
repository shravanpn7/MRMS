package cmpe18032;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class Queries extends BCrypt {
	private String htmlString;
	
	public Queries() {
	}
	
	BCrypt hash = new BCrypt();

	public boolean isValidMovie(String movie, Statement stmt) {
		String sql = "select * from movies where Title ='" + movie + "'";
		String title = "";
		ResultSet rs = null;
		print("executing " + sql);
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				title += rs.getString("Title");
			}

			rs.close();
		} catch (Exception e) {
			print("cannot execute the query");
		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}
		boolean result = (title.equals(movie));
		return result;
	}

	public boolean searchMovie(String movie, Statement stmt) {
		String sql = "select ISBN, Title, Year from movies where Title ='"
				+ movie + "'";
		String title = "";
		String MovieID = "";
		int Year = 0;
		ResultSet rs = null;
		print("executing " + sql);
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				title = rs.getString("Title");
				MovieID = rs.getString("MovieID");
				Year = rs.getInt("Year");
				print("MovieID: " + MovieID + " - Movie: " + title + " - Year: "
						+ Year + "\n");
			}

			rs.close();
		} catch (Exception e) {
			print("cannot execute the query");
		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		boolean result = (title.equals(movie));
		return result;
	}

	public class Movies {
		private String Title;
		private String MovieID;

		public void setTitle(String Title) {
			this.Title = Title;
		}

		public String getTitle() {
			return this.Title;
		}

		public String getMovieID() {
			return this.MovieID;
		}

		public void setMovieID(String MovieID) {
			this.MovieID = MovieID;
		}
	}

	public List<Movies> _list() throws Exception {
		Connection con = null;
		ResultSet rs = null;
		List<Movies> result = new ArrayList<Movies>();
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver").newInstance();
			String url = "jdbc:mysql://localhost:3306/mrms";
			String userName = "root";
			String password = "password";
			con = DriverManager.getConnection(url, userName, password);
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery("Select MovieID, Title from Movies");
			while (rs.next()) {
				Movies mov = new Movies();
				mov.setMovieID(rs.getString("MovieID"));
				mov.setTitle(rs.getString("Title"));
				result.add(mov);
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			if (null != rs) {
				try {
					rs.close();
				} catch (Exception ex) {
				}
				;
			}
			if (null != con) {
				try {
					con.close();
				} catch (Exception ex) {
				}
				;
			}
		}
		return result;
	}

	public void getMovies(Statement stmt, String S) {
		String sql = "select MovieID, Title from movies";
		ResultSet rs = null;
		print("executing " + sql);
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				String MovieID = rs.getString("MovieID");
				String Title = rs.getString("Title");
				print("Movie ID: " + MovieID + "\t" + "Title: " + Title + "\n");

			}

			rs.close();
		} catch (Exception e) {
			print("cannot execute the query");
		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}
		return;
	}

	public String rateMovie(Statement stmt, String CustID, String MovieID, String rating) {
		this.setHtmlString("");
		Float avgRate = 0.0f;
		String sql = "insert into rating values('" + CustID + "','" + MovieID + "','" + rating + "')";
		String sql2 = "SELECT AVG(rating) from rating where MovieID = '" + MovieID + "'";
		
		
		ResultSet rs = null;
		print("executing " + sql);
		try {	
			stmt.executeUpdate(sql);
			rs = stmt.executeQuery(sql2);
			while(rs.next()) {
				avgRate = rs.getFloat(1);
				System.out.println(avgRate);
			}
			String sql3 = "UPDATE movies SET Rate = " + avgRate + " where MovieID = '" + MovieID + "'";
			int count = stmt.executeUpdate(sql3);
			//System.out.println("count "+ count);

		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		
		
		return this.getHtmlString();
		
	}
	
	public String addNewCustomer(Statement stmt, String CustID,
			String password, String firstName, String lastName,
			String middleName, String houseNo, String street, String city,
			String phone, String ccNumber, String email, String regDate,
			String memType) {
		this.setHtmlString("");
				
		password = BCrypt.hashpw(password, BCrypt.gensalt()) ;
		
		String sql = "insert into customer values('" + CustID + "','"
				+ password + "','" + email + "','" + phone + "','" + firstName
				+ "','" + lastName + "','" + middleName + "','" + houseNo
				+ "','" + street + "','" + city + "','" + regDate + "','"
				+ memType + "','" + ccNumber + "');";
		ResultSet rs = null;
		print("executing " + sql);
		try {
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return this.getHtmlString();
	}

	
	
	public void addMovie(Statement stmt, String MovieID, String Title,
			String Year, String Genre, String Copies) {
		String sql = "insert into movies (MovieID, Title, Year, Genre, Copies) values('" + MovieID + "','" + Title + "','" + Year + "','" + Genre + "','"
				+ Copies + "');";
		ResultSet rs = null;
		print("executing " + sql);
		try {
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return;

	}

	public void updateMovies(Statement stmt, String ISBN, String count,
			int startCount, String mediaType) {
		int difference = startCount - Integer.parseInt(count);
		if (difference < 0) {
			print("You have request too many " + mediaType + "(s)\n");
			return;
		}
		String sql = "update movies set " + mediaType + " = " + difference
				+ " where ISBN = '" + ISBN + "'";
		ResultSet rs = null;
		print("executing " + sql);
		try {
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return;
	}

	public void addMovieInv(Statement stmt, String ISBN, String addition,
			int startCount, String mediaType) {
		int add = Integer.parseInt(addition);
		if (add < 0) {
			print("You must add a positve number of new copies!");
			return;
		}
		int sum = startCount + add;

		String sql = "update movies set " + mediaType + " = " + sum
				+ " where ISBN = '" + ISBN + "'";
		ResultSet rs = null;
		print("executing " + sql);
		try {
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return;
	}

	public String addMovieFeed(Statement stmt, String login, String ISBN,
			String CustomerRating, String MovieFeedback) {
		this.setHtmlString("");
		int cr = Integer.parseInt(CustomerRating);
		if (cr < 1 || cr > 10) {
			print("Your movie rating must be between 1 and 10!");
			return this.getHtmlString();
		}

		String sql = "insert into CustomerMovieResponse Values('" + login
				+ "', '" + ISBN + "', " + cr + ",'" + MovieFeedback
				+ "', NOW());";
		ResultSet rs = null;
		print("executing " + sql);
		try {
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return this.getHtmlString();
	}



	public String addTrustRating(Statement stmt, String login, String aLogin,
			String _rating) {
		this.setHtmlString("");
		String rating = _rating;
		String trustR = "";
		if (rating.equals("yes")) {
			trustR = "Trusted";
		} else if (rating.equals("no")) {
			trustR = "Non-Trusted";
		} else {
			print("Your trust response was not valid!");
			return this.getHtmlString();
		}
		String sql = "insert into TrustRatings Values('" + login + "', '"
				+ aLogin + "','" + trustR + "');";
		ResultSet rs = null;
		print("executing " + sql);
		try {
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return this.getHtmlString();
	}

	public static String getCurrentTimeStamp() {
		DateFormat timeFormat = new SimpleDateFormat("HH:mm:SS");// dd/MM/yyyy
		Date d = new Date(0);
		return timeFormat.format(d);
	}

	public String createOrder(Statement stmt, String login, String movieid) {
		this.setHtmlString("");

		//String Ttime = getCurrentTimeStamp();
		//java.sql.Time T_time = java.sql.Time.valueOf(Ttime);
		
		Calendar cal = Calendar.getInstance();
    	cal.getTime();
    	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
    	String T_time = sdf.format(cal.getTime());
	
		String T_date = "2014-05-07";
		String Due_date = "2014-05-12";
		String comma = ",";
		String sql = "insert into transaction (CustID, MovieID, T_time,T_date,Due_date) values('"
				+ login + "','" + movieid + "','" + T_time + "','" + T_date + "','" + Due_date + "')";
		ResultSet rs = null;
		print("executing " + sql);
		try {
			stmt.executeUpdate(sql);
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return this.getHtmlString();
	}

	public int getMovieCount(Statement stmt, String ISBN, String mediaType) {
		String sql = "select " + mediaType + " from movies where ISBN = '"
				+ ISBN + "';";
		int count = 0;
		ResultSet rs = null;
		print("executing " + sql);
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				count = rs.getInt(mediaType);
			}

			rs.close();
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return count;
	}

	public String getUserPersonalData(Statement stmt, String login) {
		String sql = "select * from customers where login = '" + login + "';";
		String firstName, lastName, address, city, state, postalCode, phone, ccNumber;
		ResultSet rs = null;
		print("executing " + sql);
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				firstName = rs.getString("FirstName");
				lastName = rs.getString("LastName");
				address = rs.getString("StreetAddress");
				city = rs.getString("City");
				state = rs.getString("State");
				postalCode = rs.getString("PostalCode");
				phone = rs.getString("Phone");
				ccNumber = rs.getString("ccNumber");

				print("First Name - " + firstName);
				print("Last Name - " + lastName);
				print("Address - " + address);
				print("City - " + city);
				print("State - " + state);
				print("Postal Code - " + postalCode);
				print("Phone Number - " + phone);
				print("Credit Card Number - " + ccNumber);
			}

			rs.close();
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return this.getHtmlString();
	}

	public String getSalesHistory(Statement stmt, String login) {
		this.setHtmlString("");
		String sql = "Select Title, a.DVDQuantity, a.BluRayQuantity, a.HDQuantity, a.VCDQuantity, a.OrderDate from movies m, (Select * from orders Where login = '"
				+ login + "' )a where m.ISBN = a.ISBN;";
		String title;
		Date orderDate;
		int dvd, br, hd, vcd;
		ResultSet rs = null;
		print("executing " + sql);
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				title = rs.getString("Title");
				orderDate = rs.getDate("OrderDate");

				dvd = rs.getInt("DVDQuantity");
				br = rs.getInt("BluRayQuantity");
				hd = rs.getInt("hdQuantity");
				vcd = rs.getInt("vcdQuantity");
				print("Title, OrderDate, DVD, BluRay, HDDVD, VCD");
				print(title + ", " + orderDate + ", " + dvd + ", " + br + ", "
						+ hd + ", " + vcd);
			}

			rs.close();
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return this.getHtmlString();
	}

	public String getMovieFeedback(Statement stmt, String login) {
		this.setHtmlString("");
		String sql = "Select Title, a.CustomerRating, a.MovieFeedback, a.Date from movies m, (Select * from CustomerMovieResponse Where login = '"
				+ login + "' )a where m.ISBN = a.ISBN;";
		String title, mFeedback;
		Date sDate;
		int cRating;
		ResultSet rs = null;
		print("executing " + sql);
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				title = rs.getString("Title");
				sDate = rs.getDate("Date");
				mFeedback = rs.getString("MovieFeedback");
				cRating = rs.getInt("CustomerRating");

				print("Title, Date, Movie Feedback, Customer Rating");
				print(title + ", " + sDate + ", " + mFeedback + ", " + cRating);
			}

			rs.close();
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return this.getHtmlString();
	}

	
	
	public ArrayList<String> getSearchResults(Statement stmt,
			ArrayList<String> aList, ArrayList<String> mList) {
		ArrayList<String> tempList = new ArrayList<String>();
		String from = "";
		String join = "";
		boolean isWhereAdded = false;
		if (!aList.isEmpty()) {
			from = from + " movie_cast mc, cast, movies";
			if (isWhereAdded) {
				join += " and mc.MovieID = movies.MovieID and mc.castid = cast.castid ";
			} else {
				join += " where movies.MovieID = mc.MovieID and mc.castid = cast.castid ";
				isWhereAdded = true;
			}

			if (!aList.isEmpty()) {
				for (String s : aList) {
					if (!(s.trim()).isEmpty())
						join = join + " and cast.Name = '" + s + "'";
				}
			}

		}
		if (!mList.isEmpty()) {
			from.concat(" movie_cast mc, movies");
			if (isWhereAdded) {
				join.concat(" and movies.MovieID = mc.MovieID");
			} else {
				join.concat(" where movies.MovieID = mc.MovieID ");
				isWhereAdded = true;
			}

			if (!mList.isEmpty()) {
				for (String s : mList) {
					if (!(s.trim()).isEmpty())
					join = join + " and movies.Title = '" + s + "'";
				}
			}

		}
		
		String sql = "Select movies.MovieID ,movies.Title, movies.Year, movies.Genre, cast.castid, cast.Name from";
		sql = sql + " " + from;
		sql = sql + join;
		String MovieID, Title, Genre, castid, Name;
		int Year;

		ResultSet rs = null;
		print("executing " + sql);
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {

				MovieID = rs.getString("MovieID");
				Title = rs.getString("Title");
				Genre = rs.getString("Genre");
				Year = rs.getInt("Year");
				castid = rs.getString("castid");
				Name = rs.getString("Name");

				print(MovieID + ", " + Title + ", " + Genre + ", " + Year
						+ ", " + castid + ", " + Name);
				String s = MovieID + ", " + Title + ", " + Genre + ", " + Year
						+ ", " + castid + Name;
				tempList.add(s);
			}

			rs.close();
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return tempList;
	}

	public void print(String s) {
		System.out.println(s);
		String temp = this.getHtmlString();
		temp += "<p>" + s + "</p>\n";
		this.setHtmlString(temp);

	}

	public String getDegree(Statement stmt, String FNactor1, String LNactor1,
			String FNactor2, String LNactor2, int level) {
		this.setHtmlString("");
		String sql = "Select actors.LastName, actors.FirstName from actors, (Select actorsMovies.ActorID from actorsMovies,(Select ISBN, actors.ActorID from actors, actorsMovies where actors.LastName = '"
				+ LNactor1
				+ "' and actors.FirstName = '"
				+ FNactor1
				+ "') aMovies where actorsMovies.ISBN = aMovies.ISBN and aMovies.ActorID != actorsMovies.ActorID Group by actorsMovies.ActorID) moviesIn where moviesIn.ActorID = actors.ActorID";
		String actor2 = LNactor2 + " " + FNactor2;
		String actor1 = LNactor1 + " " + FNactor1;
		String ln;
		String fn;
		ArrayList<String> actorsList = new ArrayList<String>();
		ResultSet rs = null;
		print("executing " + sql);
		if (level > 1) {
			print("Degree of separation was undetermined.");
			return this.getHtmlString();
		}
		try {
			rs = stmt.executeQuery(sql);
			while (rs.next()) {

				ln = rs.getString("LastName");
				fn = rs.getString("FirstName");
				String temp = ln + " " + fn;
				if (actor2.equals(temp)) {
					int newLevel = level + 1;
					print(actor1 + " is separated by " + newLevel
							+ " degree(s) of separeation from " + actor2 + ".");
					return this.getHtmlString();
				} else {
					actorsList.add(temp);
				}
			}
			for (String s : actorsList) {
				int temp = s.indexOf(" ");
				String LastName = s.substring(0, temp);
				String FirstName = s.substring(temp + 1, s.length() + 1);

				this.getDegree(stmt, FNactor2, LNactor2, FirstName, LastName,
						level);
			}

			rs.close();
		} catch (Exception e) {
			print("cannot execute the query: " + e.toString());

		} finally {
			try {
				if (rs != null && !rs.isClosed())
					rs.close();
			} catch (Exception e) {
				print("cannot close resultset");
			}
		}

		return this.getHtmlString();

	}

	public String getHtmlString() {
		return htmlString;
	}

	public void setHtmlString(String htmlString) {

		this.htmlString = htmlString;
	}

}
