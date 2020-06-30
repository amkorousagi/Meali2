package dao;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;

public class blob {
	public InputStream BlobtoStream(Blob blob)
	{
		try {
			return blob.getBinaryStream();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
