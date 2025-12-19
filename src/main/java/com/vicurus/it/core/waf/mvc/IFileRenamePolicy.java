package com.vicurus.it.core.waf.mvc;

import java.io.File;

public interface IFileRenamePolicy {
	public abstract File renameFile(File file);
}
